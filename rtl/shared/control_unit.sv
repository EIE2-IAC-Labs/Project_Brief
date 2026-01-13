module control_unit (

    input  logic [6:0] opcode,   // instr[6:0]
    input  logic [2:0] funct3,   // instr[14:12]
    input logic [6:0] funct7,   // for later when R-type ALU is added

    output logic       RegWrite,
    output logic       MemWrite,
    output logic       MemRead,
    output logic       ALUSrc,      // 1: use ImmExt as srcB, 0: use rs2
    output logic       Branch,      //(B-type)?
    output logic       Jump,        // jal (J-type)?
    output logic       Jalr,        // jalr (I-type)?
    output logic [2:0] ImmSrc,      // 000=I, 001=S, 010=B, 011=U, 100=J
    output logic [1:0] ResultSrc,   // 00=ALU (ADD...), 01=Mem (LBU), 10=PC+4 (JAL, JALR)
    output logic [3:0] ALUControl
);

//Opcode constants:
localparam OPC_LOAD    = 7'b0000011; // lbu
localparam OPC_STORE   = 7'b0100011; // sb
localparam OPC_OP_IMM  = 7'b0010011; // addi
localparam OPC_OP      = 7'b0110011; // add
localparam OPC_LUI     = 7'b0110111; // lui /li
localparam OPC_BRANCH  = 7'b1100011; // bne
localparam OPC_JALR    = 7'b1100111; // jalr
localparam OPC_JAL     = 7'b1101111; // jal

//ALUControl:
// ALUControl (must match alu.sv)
localparam [3:0]
    ALU_ADD    = 4'b0000,
    ALU_SUB    = 4'b0001,
    ALU_PASS_B = 4'b0010,
    ALU_SLTU   = 4'b0011,
    ALU_SLT    = 4'b0100,
    ALU_XOR    = 4'b0101,
    ALU_OR     = 4'b0110,
    ALU_AND    = 4'b0111,
    ALU_SLL    = 4'b1000,
    ALU_SRL    = 4'b1001,
    ALU_SRA    = 4'b1010;


//ResultSrc:
localparam RES_ALU     = 2'b00;      // rd = ALUResult
localparam RES_MEM     = 2'b01;      // rd = ReadData (lbu)
localparam RES_PC4     = 2'b10;      // rd = PC+4 (jal / jalr)


always_comb begin
    //defaults = NOP
    RegWrite   = 1'b0;
    MemWrite   = 1'b0;
    MemRead    = 1'b0;
    ALUSrc     = 1'b0;
    Branch     = 1'b0;
    Jump       = 1'b0;
    Jalr       = 1'b0;
    ImmSrc     = 3'b000;
    ResultSrc  = RES_ALU;
    ALUControl = ALU_ADD;

    unique case (opcode)

            // R-type ALU operations: ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
        OPC_OP: begin
            RegWrite   = 1'b1;
            MemWrite   = 1'b0;
            MemRead    = 1'b0;
            ALUSrc     = 1'b0; 
            ResultSrc  = RES_ALU;    // write ALU result to rd
            unique case (funct3)
                3'b000: begin // ADD / SUB
                    if (funct7 == 7'b0100000)
                        ALUControl = ALU_SUB;   // SUB
                    else
                        ALUControl = ALU_ADD;   // ADD (funct7 = 0000000)
                end
                3'b001: begin // SLL
                    ALUControl = ALU_SLL;
                end
                3'b010: begin // SLT
                    ALUControl = ALU_SLT;
                end
                3'b011: begin // SLTU
                    ALUControl = ALU_SLTU;
                end
                3'b100: begin // XOR
                    ALUControl = ALU_XOR;
                end
                3'b101: begin // SRL / SRA
                    if (funct7 == 7'b0100000)
                        ALUControl = ALU_SRA;   // arithmetic
                    else
                        ALUControl = ALU_SRL;   // logical
                end
                3'b110: begin // OR
                    ALUControl = ALU_OR;
                end
                3'b111: begin // AND
                    ALUControl = ALU_AND;
                end
                default: begin
                    // illegal funct3: treat as NOP
                    RegWrite = 1'b0;
                end
            endcase
        end

            // I-type ALU operations: ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
        OPC_OP_IMM: begin
            RegWrite   = 1'b1;
            MemWrite   = 1'b0;
            MemRead    = 1'b0;
            ALUSrc     = 1'b1; 
            ImmSrc     = 3'b000;
            ResultSrc  = RES_ALU;
            unique case (funct3)
                3'b000: begin // ADDI
                    ALUControl = ALU_ADD;
                end
                3'b010: begin // SLTI
                    ALUControl = ALU_SLT;
                end
                3'b011: begin // SLTIU
                    ALUControl = ALU_SLTU;
                end
                3'b100: begin // XORI
                    ALUControl = ALU_XOR;
                end
                3'b110: begin // ORI
                    ALUControl = ALU_OR;
                end
                3'b111: begin // ANDI
                    ALUControl = ALU_AND;
                end
                3'b001: begin // SLLI
                    // In RV32I, imm[11:5] must be 0000000, which we see as funct7
                    if (funct7 == 7'b0000000)
                        ALUControl = ALU_SLL;
                    else
                        RegWrite = 1'b0; // illegal, treat as NOP
                end
                3'b101: begin // SRLI / SRAI
                    // imm[11:5] = 0000000 => SRLI, 0100000 => SRAI
                    if (funct7 == 7'b0000000)
                        ALUControl = ALU_SRL;
                    else if (funct7 == 7'b0100000)
                        ALUControl = ALU_SRA;
                    else
                        RegWrite = 1'b0; // illegal, treat as NOP
                end
                default: begin
                    // unknown funct3: treat as NOP
                    RegWrite = 1'b0;
                end
            endcase
        end

        
        //Load: LB, LH, LW, LBU, LHU
        OPC_LOAD: begin
            unique case (funct3)
                3'b000: begin // LB - Load Byte (sign-extended)
                    RegWrite   = 1'b1;
                    MemWrite   = 1'b0;
                    MemRead    = 1'b1;
                    ALUSrc     = 1'b1;
                    ImmSrc     = 3'b000;
                    ResultSrc  = RES_MEM;
                    ALUControl = ALU_ADD;
                end
                3'b001: begin // LH - Load Halfword (sign-extended)
                    RegWrite   = 1'b1;
                    MemWrite   = 1'b0;
                    MemRead    = 1'b1;
                    ALUSrc     = 1'b1;
                    ImmSrc     = 3'b000;
                    ResultSrc  = RES_MEM;
                    ALUControl = ALU_ADD;
                end
                3'b010: begin // LW - Load Word
                    RegWrite   = 1'b1;
                    MemWrite   = 1'b0;
                    MemRead    = 1'b1;
                    ALUSrc     = 1'b1;
                    ImmSrc     = 3'b000;
                    ResultSrc  = RES_MEM;
                    ALUControl = ALU_ADD;
                end
                3'b100: begin // LBU - Load Byte Unsigned
                    RegWrite   = 1'b1;
                    MemWrite   = 1'b0;
                    MemRead    = 1'b1;    // read memory
                    ALUSrc     = 1'b1;      // base + offset
                    ImmSrc     = 3'b000;    
                    ResultSrc  = RES_MEM;   // data from memory
                    ALUControl = ALU_ADD;   // address = rs1 + imm
                end
                3'b101: begin // LHU - Load Halfword Unsigned
                    RegWrite   = 1'b1;
                    MemWrite   = 1'b0;
                    MemRead    = 1'b1;
                    ALUSrc     = 1'b1;
                    ImmSrc     = 3'b000;
                    ResultSrc  = RES_MEM;
                    ALUControl = ALU_ADD;
                end
                default: begin
                    // Invalid funct3 for load, treat as NOP
                end
            endcase
        end
            
        //Store: SB, SH, SW
        OPC_STORE: begin
            unique case (funct3)
                3'b000: begin // SB - Store Byte
                    RegWrite   = 1'b0;
                    MemWrite   = 1'b1;      // write memory no read form memory now
                    ALUSrc     = 1'b1;      // base + offset
                    ImmSrc     = 3'b001;    
                    ALUControl = ALU_ADD;
                end
                3'b001: begin // SH - Store Halfword
                    RegWrite   = 1'b0;
                    MemWrite   = 1'b1;
                    ALUSrc     = 1'b1;
                    ImmSrc     = 3'b001;
                    ALUControl = ALU_ADD;
                end
                3'b010: begin // SW - Store Word
                    RegWrite   = 1'b0;
                    MemWrite   = 1'b1;
                    ALUSrc     = 1'b1;
                    ImmSrc     = 3'b001;
                    ALUControl = ALU_ADD;
                end
                default: begin
                    // Invalid funct3 for store, treat as NOP
                end
            endcase
        end

        //U-type: lui
        OPC_LUI: begin
            RegWrite   = 1'b1;
            ALUSrc     = 1'b1;         // use ImmExt as B
            ImmSrc     = 3'b011;
            ResultSrc  = RES_ALU;      // rd = ImmExt
            ALUControl = ALU_PASS_B;
         end

        //Branches: all types
        OPC_BRANCH: begin
            RegWrite   = 1'b0;
            MemWrite   = 1'b0;
            ALUSrc     = 1'b0;         // compare rs1 vs rs2
            Branch     = 1'b1; 
            ImmSrc     = 3'b010;
            unique case (funct3)
                3'b000: begin // BEQ
                    ALUControl = ALU_SUB;   
                end
                3'b001: begin // BNE
                    ALUControl = ALU_SUB;   // Zero==0 => taken
                end
                3'b100: begin // BLT (signed less than)
                    ALUControl = ALU_SLT;
                end
                3'b101: begin // BGE (signed greater or equal)
                    ALUControl = ALU_SLT;
                end
                3'b110: begin // BLTU (unsigned less than)
                    ALUControl = ALU_SLTU;
                end
                3'b111: begin // BGEU (unsigned greater or equal)
                    ALUControl = ALU_SLTU;  // result = (rs1<rs2); Zero==1 => taken
                end
                default: begin
                    Branch = 1'b0;
                end
            endcase
        end

        
        //JALR (used for RET)
        OPC_JALR: begin
            if (funct3 == 3'b000) begin
                RegWrite   = 1'b1;
                MemWrite   = 1'b0;
                ALUSrc     = 1'b1;      // rs1 + imm
                Jalr       = 1'b1;      // special PC path
                ImmSrc     = 3'b000;
                ResultSrc  = RES_PC4;   // rd = PC+4
                ALUControl = ALU_ADD;
             end
            end

        //JAL
        OPC_JAL: begin
            RegWrite   = 1'b1;
            MemWrite   = 1'b0;
            Jump       = 1'b1;          // unconditional PC jump
            ImmSrc     = 3'b100; 
            ResultSrc  = RES_PC4;
            ALUControl = ALU_ADD;
            end
        
        
        default: begin
                //defaults NOP
                end
                
        endcase
    end

endmodule

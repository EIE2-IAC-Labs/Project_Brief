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
    output logic [2:0] ALUControl
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
localparam ALU_ADD     = 3'b000;
localparam ALU_SUB     = 3'b001;
localparam ALU_PASS_B  = 3'b010;
localparam ALU_SLTU    = 3'b011;

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
    
        //R-type: add
        OPC_OP: begin
            if (funct3 == 3'b000 && funct7 == 7'b0000000) begin
                RegWrite   = 1'b1;
                ALUSrc     = 1'b0;       // rs2
                ResultSrc  = RES_ALU;
                ALUControl = ALU_ADD;
                end
            end
            
        //I-type ALU: addi
        OPC_OP_IMM: begin
            if (funct3 == 3'b000) begin
                RegWrite   = 1'b1;
                ALUSrc     = 1'b1;      // immediate
                ImmSrc     = 3'b000;    
                ResultSrc  = RES_ALU;
                ALUControl = ALU_ADD;
                end
            end
        
        //Load: lbu
        OPC_LOAD: begin
            if (funct3 == 3'b100) begin
                RegWrite   = 1'b1;
                MemWrite   = 1'b0;
                MemRead    = 1'b1;    // read memory
                ALUSrc     = 1'b1;      // base + offset
                ImmSrc     = 3'b000;    
                ResultSrc  = RES_MEM;   // data from memory
                ALUControl = ALU_ADD;   // address = rs1 + imm
                end
            end
            
        //Store: sb
        OPC_STORE: begin
            if (funct3 == 3'b000) begin
                RegWrite   = 1'b0;
                MemWrite   = 1'b1;      // write memory no read form memory now
                ALUSrc     = 1'b1;      // base + offset
                ImmSrc     = 3'b001;    
                ALUControl = ALU_ADD; 
                end
            end

        //U-type: lui
        OPC_LUI: begin
            RegWrite   = 1'b1;
            ALUSrc     = 1'b1;         // use ImmExt as B
            ImmSrc     = 3'b011;
            ResultSrc  = RES_ALU;      // rd = ImmExt
            ALUControl = ALU_PASS_B;
         end

        //Branches: bne, bgeu
        OPC_BRANCH: begin
            RegWrite   = 1'b0;
            MemWrite   = 1'b0;
            ALUSrc     = 1'b0;         // compare rs1 vs rs2
            Branch     = 1'b1; 
            ImmSrc     = 3'b010;
            unique case (funct3)
                3'b001: begin // BNE
                    ALUControl = ALU_SUB;   // Zero==0 => taken
                    end
                3'b111: begin //BGEU
                    ALUControl = ALU_SLTU;  // result = (rs1<rs2); Zero==1 => taken
                    end
                default: begin //treat as NOP
                    Branch     = 1'b0;
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

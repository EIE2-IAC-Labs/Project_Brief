module top (
    input  logic        clk,
    input  logic        rst,
    input  logic        trigger,  // Trigger signal for F1 program
    output logic [31:0] a0  // Output register x10 for verification
);

    // Instruction Memory signals
    logic [31:0] PC;
    logic [31:0] Instr;
    
    // Data Memory signals
    logic [31:0] ALUResult;
    logic [31:0] WriteData;
    logic [31:0] ReadData;
    logic        MemWrite;
    
    // Control Unit signals
    logic        RegWrite;
    logic        ALUSrc;
    logic        Branch;
    logic        Jump;
    logic        Jalr;
    logic [2:0]  ImmSrc;
    logic [1:0]  ResultSrc;
    logic [2:0]  ALUControl;
    logic        Zero;
    
    // PC logic signals
    logic [31:0] PCPlus4;
    logic [31:0] PCTarget;
    logic [31:0] PCNext;
    logic        PCSrc;
    
    // Immediate extension
    logic [31:0] ImmExt;
    
    // Extract instruction fields
    wire [6:0] opcode = Instr[6:0];
    wire [2:0] funct3 = Instr[14:12];
    wire [6:0] funct7 = Instr[31:25];
    
    // PC Register
    pc_reg pc_register (
        .clk(clk),
        .rst(rst),
        .pc_next(PCNext),
        .pc(PC)
    );
    
    // Instruction Memory
    instr_mem instruction_memory (
        .addr_i(PC),
        .instr_o(Instr)
    );
    
    // Control Unit
    control_unit control (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .Jump(Jump),
        .Jalr(Jalr),
        .ImmSrc(ImmSrc),
        .ResultSrc(ResultSrc),
        .ALUControl(ALUControl)
    );
    
    // Datapath
    datapath data_path (
        .clk(clk),
        .rst(rst),
        .Instr(Instr),
        .ReadData(ReadData),
        .PCPlus4(PCPlus4),
        .RegWrite(RegWrite),
        .ResultSrc(ResultSrc),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .ImmSrc(ImmSrc),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .Zero(Zero),
        .a0(a0)
    );
    
    // Data Memory
    data_mem data_memory (
        .clk(clk),
        .addr_i(ALUResult),
        .write_data_i(WriteData),
        .write_en_i(MemWrite),
        .funct3_i(funct3),
        .read_data_o(ReadData)
    );
    
    // PC + 4 calculation
    assign PCPlus4 = PC + 32'd4;
    
    // Get immediate extension for PC target calculation
    extend ext_for_pc (
        .instr(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );
    
    // PC Target calculation (PC + ImmExt for branches and JAL)
    assign PCTarget = PC + ImmExt;
    
    // Branch decision logic
    // For BNE: take branch if Zero == 0 (not equal)
    // For BGEU: take branch if Zero == 1 (rs1 >= rs2, i.e., not less than)
    logic BranchTaken;
    always_comb begin
        case (funct3)
            3'b001: BranchTaken = Branch && !Zero;  // BNE: taken if not equal
            3'b111: BranchTaken = Branch && Zero;   // BGEU: taken if rs1 >= rs2
            default: BranchTaken = 1'b0;
        endcase
    end
    
    // PC source selection
    assign PCSrc = BranchTaken || Jump;
    
    // PC next calculation
    always_comb begin
        if (Jalr)
            PCNext = ALUResult;       // JALR: PC = rs1 + imm (computed by ALU)
        else if (PCSrc)
            PCNext = PCTarget;        // Branch taken or JAL: PC = PC + ImmExt
        else
            PCNext = PCPlus4;         // Default: PC = PC + 4
    end

endmodule

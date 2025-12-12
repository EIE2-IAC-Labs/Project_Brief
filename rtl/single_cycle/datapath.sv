module datapath (
    input logic        clk,
    input logic        rst,

    //Inputs from other modules
    input logic [31:0] Instr, // Instruction from Memory
    input logic [31:0] ReadData, // Data from Data Memory
    input logic [31:0] PCPlus4, // From PC Reg

    //Control Signals (from Control Unit)
    input logic        RegWrite, // Register File Write Enable
    input logic [1:0]  ResultSrc, // 00=ALU, 01=Mem, 10=PC+4
    input logic        ALUSrc,   // 0=Reg, 1=Imm
    input logic [3:0]  ALUControl, // changed to 4 bits for full rv32i design
    input logic [2:0]  ImmSrc,

    //Outputs
    output logic [31:0] ALUResult, // To Data Mem Addr / PC logic
    output logic [31:0] WriteData, // To Data Mem Data
    output logic        Zero,       // To Control Unit
    output logic [31:0] a0 // Output register for testbench
);

    //Internal Wires
    logic [31:0] SrcA;
    logic [31:0] SrcB;
    logic[31:0] Result;
    logic [31:0] ImmExt;

    //Register File Instance
    register_file RF (
        .clk (clk),
        .rst (rst),
        .WE3 (RegWrite),
        .A1 (Instr[19:15]),
        .A2 (Instr[24:20]),
        .A3 (Instr[11:7]),
        .WD3 (Result),
        .RD1 (SrcA),
        .RD2 (WriteData),
        .a0 (a0)
    );

    //Extend Unit Instance
    extend ext (
        .instr (Instr),
        .ImmSrc (ImmSrc),
        .ImmExt (ImmExt)
    );

    // ALU SrcB Mux - Choice between RD2 or ImmExt - depends on ALUSrc
    assign SrcB = (ALUSrc) ? ImmExt : WriteData;

    // ALU Instance
    alu alu_core (
        .SrcA (SrcA),
        .SrcB (SrcB),
        .ALUControl (ALUControl),
        .ALUResult (ALUResult),
        .Zero (Zero)
    );

    // Result Mux - Choice between ALUResult, ReadData, PCPlus4 - depends on ResultSrc
    always_comb begin
        case (ResultSrc)
            2'b00: Result = ALUResult; // From ALU
            2'b01: Result = ReadData;  // From Data Memory
            2'b10: Result = PCPlus4;   // From PC + 4
            default: Result = 32'b0;    // Default case
        endcase
    end

endmodule

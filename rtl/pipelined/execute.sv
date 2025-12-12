module execute (
    // Control Signals (From ID/EX Register)
    input  logic        ALUSrcE,
    input  logic [3:0]  ALUControlE,

    // Data Inputs (From ID/EX Register)
    input  logic [31:0] rs1_dataE,
    input  logic [31:0] rs2_dataE,
    input  logic [31:0] ImmExtE,
    input  logic [31:0] PCE,          // PC in EX stage

    // Forwarding control
    input  logic [1:0]  ForwardAE,
    input  logic [1:0]  ForwardBE,

    // Forwarding data
    input  logic [31:0] ALUResultM,   // from MEM stage
    input  logic [31:0] ResultW,      // from WB stage

    // Branch type (funct3 for branch instructions)
    input  logic [2:0]  funct3E,

    // Outputs to EX/MEM
    output logic [31:0] ALUResultE,
    output logic [31:0] WriteDataE,
    output logic [31:0] PCTargetE,

    // Output to hazard unit
    output logic        cond_trueE
);

    // Forwarded sources
    logic [31:0] SrcAE_forwarded;
    logic [31:0] SrcBE_forwarded;
    logic [31:0] SrcAE_final;
    logic [31:0] SrcBE_final;
    logic        ZeroE;

    always_comb begin
        case (ForwardAE)
            2'b00: SrcAE_forwarded = rs1_dataE;
            2'b01: SrcAE_forwarded = ResultW;      // from WB
            2'b10: SrcAE_forwarded = ALUResultM;   // from MEM
            default: SrcAE_forwarded = rs1_dataE;
        endcase
    end

    always_comb begin
        case (ForwardBE)
            2'b00: SrcBE_forwarded = rs2_dataE;
            2'b01: SrcBE_forwarded = ResultW;
            2'b10: SrcBE_forwarded = ALUResultM;
            default: SrcBE_forwarded = rs2_dataE;
        endcase
    end

    // Final ALU operands
    assign SrcAE_final = SrcAE_forwarded;
    assign SrcBE_final = (ALUSrcE) ? ImmExtE : SrcBE_forwarded;

    alu alu_inst (
        .SrcA      (SrcAE_final),
        .SrcB      (SrcBE_final),
        .ALUControl(ALUControlE),
        .ALUResult (ALUResultE),
        .Zero      (ZeroE)
    );


    assign PCTargetE = PCE + ImmExtE;

    always_comb begin
        case (funct3E)
            3'b000: cond_trueE = ZeroE;           // BEQ
            3'b001: cond_trueE = ~ZeroE;          // BNE
            3'b100: cond_trueE = ALUResultE[0];   // BLT  (SLT result)
            3'b101: cond_trueE = ~ALUResultE[0];  // BGE
            3'b110: cond_trueE = ALUResultE[0];   // BLTU (SLTU result)
            3'b111: cond_trueE = ~ALUResultE[0];  // BGEU
            default: cond_trueE = 1'b0;
        endcase
    end

    // rs2 value after forwarding
    assign WriteDataE = SrcBE_forwarded;

endmodule


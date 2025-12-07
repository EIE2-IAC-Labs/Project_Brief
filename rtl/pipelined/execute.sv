module execute (
    input logic              clk,

    // Control Signals (From ID/EX Register)
    input logic             ALUSrcE,
    input logic [2:0]    ALUControlE,

    // Data Inputs (From ID/EX Register)
    input logic [31:0]    rs1_dataE, //Data read from Reg[rs1]
    input logic [31:0]    rs2_dataE, //Data read from Reg[rs2]
    input logic [31:0]    ImmExtE, //Extended Immediate
    input logic [31:0]      PCE,  //Program Counter at this stage

    // Forwarding Inputs
    input logic [1:0]    ForwardAE, // Select logic for SrcA
    input logic [1:0]    ForwardBE, // Select logic for SrcB

    // Forwarding Data 
    input logic [31:0]    ALUResultM, // Data forwarded from Memory Stage
    input logic [31:0]    ResultW,    // Data forwarded from Writeback Stage

    // Outputs to Ex/MEM Register
    output logic [31:0]   ALUResultE, // The calculation result
    output logic [31:0]   WriteDataE, // The data to store in memory (forwarded rs2)
    output logic [31:0]   PCTargetE, // Calulated Branch Target

    // Output to Hazard Unit
    output logic         cond_trueE // High if branch condition is met
);


    // Internal wires for the "Forwarding Mux" results
    logic [31:0] SrcAE;
    logic [31:0] SrcBE_forwarded;
    logic [31:0] SrcBE_Final; // The actual input to the ALU
    logic       ZeroE; // Zero flag from ALU

    //Forwarding Logic for Source A
    always_comb begin
        case (ForwardAE)
            2'b00: SrcAE = rs1_dataE; // No forwarding
            2'b01: SrcAE = ResultW; // Forward from WB stage
            2'b10: SrcAE = ALUResultM; // Forward from MEM stage
            default: SrcAE = rs1_dataE;
        endcase
    end

    //Forwarding logic for Source B
    always_comb begin
        case (ForwardBE)
            2'b00: SrcBE_forwarded = rs2_dataE; // No forwarding
            2'b01: SrcBE_forwarded = ResultW; // Forward from WB stage
            2'b10: SrcBE_forwarded = ALUResultM; // Forward from MEM stage
            default: SrcBE_forwarded = rs2_dataE;
        endcase
    end

    // This selects between the (potentially forwarded) rs2 and the Immediate
    // If ALUSrcE is 1, we use the Immediate. If it is 0, we use rs2.
    assign SrcBE_Final = (ALUSrcE) ? ImmExtE : SrcBE_forwarded;

    // You reuse your ALU from the single cycle
    alu alu_inst (
        .SrcA(SrcAE),
        .SrcB(SrcBE_Final),
        .ALUControl(ALUControlE),
        .ALUResult(ALUResultE),
        .Zero(ZeroE)
    );

    //Calculate Branch Target (PC + Immediate)
    assign PCTargetE = PCE + ImmExtE;
    
    //Determine if Branch Condition is met
    always_comb begin
        case (ALUControlE)
            3'b001:  cond_trueE = ~ZeroE; // BNE (Branch if Result != 0)
            3'b011:  cond_trueE = ZeroE;  // BGEU (Branch if SrcA >= SrcB, i.e., !(SrcA < SrcB))
            default: cond_trueE = ZeroE;  // Default for BEQ
        endcase
    end
    // Write Data Output
    // If we are doing a STORE instruction, the data we write to memory comes from rs2. 
    // However, rs2 may have been forwarded, so we output 'SrcBE_forwarded' as 'WriteDataE'.
    assign WriteDataE = SrcBE_forwarded;

endmodule






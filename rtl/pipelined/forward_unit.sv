// Data forwarding (bypassing) unit for 5-stage RV32I pipeline

module forward_unit (
    input  logic [4:0] rs1E,        //source register numbers in EX stage (from ID/EX)
    input  logic [4:0] rs2E,
    input  logic [4:0] rdM,         //destination register in MEM stage (from EX/MEM)
    input  logic       RegWriteM,   //MEM stage will write rdM
    input  logic [4:0] rdW,         //destination register in WB stage (from MEM/WB)
    input  logic       RegWriteW,   //WB stage will write rdW
    output logic [1:0] ForwardAE,   //2-bit control for ALU srcA muxe in EX
    output logic [1:0] ForwardBE    //2-bit control for ALU srcB muxe in EX
);

    always_comb begin
        // default: 00 -> use value from ID/EX (no forwarding)
        ForwardAE = 2'b00;
        ForwardBE = 2'b00;

        // Forward for rs1E (ALU srcA)
        if (RegWriteM && (rdM != 5'd0) && (rdM == rs1E)) begin
            ForwardAE = 2'b10;           // from EX/MEM (ALUResultM)
        end else if (RegWriteW && (rdW != 5'd0) && (rdW == rs1E)) begin
            ForwardAE = 2'b01;           // from MEM/WB (WriteDataW)
        end

        //Forward for rs2E (ALU srcB)
        if (RegWriteM && (rdM != 5'd0) && (rdM == rs2E)) begin
            ForwardBE = 2'b10;
        end else if (RegWriteW && (rdW != 5'd0) && (rdW == rs2E)) begin
            ForwardBE = 2'b01;
        end
    end

endmodule

module if_id_reg_dual (
    input  logic        clk,
    input  logic        rst,
    input  logic        write_enable,  // 1 = update, 0 = stall
    input  logic        flush,

    // inputs from IF
    input  logic [31:0] pcF,
    input  logic [31:0] instr0F,
    input  logic [31:0] instr1F,

    // outputs to ID
    output logic [31:0] pcD,
    output logic [31:0] instr0D,
    output logic [31:0] instr1D
);
    always_ff @(negedge clk or posedge rst) begin
        if (rst) begin
            pcD     <= 32'b0;
            instr0D <= 32'b0;   // NOP in slot 0
            instr1D <= 32'b0;   // NOP in slot 1
        end else if (flush) begin
            pcD     <= 32'b0;
            instr0D <= 32'b0;
            instr1D <= 32'b0;
        end else if (write_enable) begin
            pcD     <= pcF;
            instr0D <= instr0F;
            instr1D <= instr1F;
        end
    end
endmodule


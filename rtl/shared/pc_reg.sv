//implementing PC / PCNext / PCPlus4 / PCTarget on the diagram
module pc_reg (
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] pc_next,
    output logic [31:0] pc
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 32'hBFC0_0000;   // start at instruction memory base given on memory map
        else
            pc <= pc_next;
    end
endmodule

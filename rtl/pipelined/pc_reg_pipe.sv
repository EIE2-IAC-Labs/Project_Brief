module pc_reg_pipe (
    input  logic        clk,
    input  logic        rst,
    input  logic        en,        // Enable signal for stalling
    input  logic [31:0] pc_next,
    output logic [31:0] pc
);
    always_ff @(negedge clk or posedge rst) begin
        if (rst)
            pc <= 32'hBFC0_0000;
        else if (en)            
            pc <= pc_next;
        // else: stall (hold current value)
    end
endmodule

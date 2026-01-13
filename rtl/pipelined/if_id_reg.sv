module if_id_reg (
    input  logic        clk,
    input  logic        rst,
    input  logic        write_enable,  // IF_ID_Write from hazard_unit (1=update, 0=stall)
    input  logic        flush,         // IF_ID_Flush from hazard_unit (1=insert NOP)
    
    // Inputs from IF stage
    input  logic [31:0] pcF,           // PC in Fetch stage
    input  logic [31:0] instrF,        // Instruction from instruction memory
    
    // Outputs to ID stage
    output logic [31:0] pcD,           // PC in Decode stage
    output logic [31:0] instrD         // Instruction in Decode stage
);

    always_ff @(negedge clk or posedge rst) begin
        if (rst) begin
            // On reset, clear pipeline register
            pcD    <= 32'b0;
            instrD <= 32'b0;
        end 
        else if (flush) begin
            // On flush, insert a NOP (all control bits zero)
            pcD    <= 32'b0;
            instrD <= 32'b0;
        end 
        else if (write_enable) begin
            // Normal operation: pass values from IF to ID
            pcD    <= pcF;
            instrD <= instrF;
        end
        // else: stall - values remain unchanged (hold current state)
    end

endmodule

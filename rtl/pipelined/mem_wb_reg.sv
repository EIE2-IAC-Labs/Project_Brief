module mem_wb_reg (
    input  logic        clk,
    input  logic        rst,
    
    // Data inputs from MEM stage
    input  logic [31:0] ALUResultM,    // ALU result from MEM stage
    input  logic [31:0] ReadDataM,     // Data read from memory
    input  logic [31:0] PCPlus4M,      // PC+4 for JAL/JALR return address
    input  logic [4:0]  rdM,           // Destination register address
    
    // Control inputs from MEM stage
    input  logic        RegWriteM,     // Register write enable
    input  logic [1:0]  ResultSrcM,    
    
    // Data outputs to WB stage
    output logic [31:0] ALUResultW,
    output logic [31:0] ReadDataW,
    output logic [31:0] PCPlus4W,
    output logic [4:0]  rdW,
    
    // Control outputs to WB stage
    output logic        RegWriteW,
    output logic [1:0]  ResultSrcW
);

    always_ff @(negedge clk or posedge rst) begin
        if (rst) begin
            // On reset, clear all pipeline registers
            ALUResultW <= 32'b0;
            ReadDataW  <= 32'b0;
            PCPlus4W   <= 32'b0;
            rdW        <= 5'b0;
            
            RegWriteW  <= 1'b0;
            ResultSrcW <= 2'b00;
        end 
        else begin
            // Normal operation: pass data from MEM to WB
            ALUResultW <= ALUResultM;
            ReadDataW  <= ReadDataM;
            PCPlus4W   <= PCPlus4M;
            rdW        <= rdM;
            
            RegWriteW  <= RegWriteM;
            ResultSrcW <= ResultSrcM;
        end
    end

endmodule

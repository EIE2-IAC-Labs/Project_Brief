module exe_mem_reg (
    // 'E' after a term indicates that it is in the Execute stage
    // 'M' after a term indicates that it is in the Memory stage

    input logic clk, 
    input logic rst,
    input logic stall,  // Cache stall signal - freezes pipeline register

    // Data inputs (from the execute stage)
    input logic [31:0] ALUResultE, 
    input logic [31:0] WriteDataE, 
    input logic [31:0] PCTargetE, 
    input logic [4:0] rdE, 
    input logic [31:0] PCPlus4E,  // PC + 4 value from EX stage. We need to include this for JAL and JALR instructions. 
                                // If we don't, the value of the "Return Address" will be lost before it reaches the end. 

    input logic [2:0] funct3E,

    // Control inputs (pass-through from ID/EX)
    input logic RegWriteE, 
    input logic [1:0] ResultSrcE, 
    input logic MemWriteE,

    // Data outputs (To Memory Stage)
    output logic [31:0] ALUResultM,
    output logic [31:0] WriteDataM,
    output logic [31:0] PCTargetM, 
    output logic [4:0] rdM,
    output logic [31:0] PCPlus4M,
    output logic [2:0] funct3M,

    // Control Outputs (To Memory Stage)
    output logic RegWriteM,
    output logic [1:0] ResultSrcM,
    output logic MemWriteM
);

    // On the rising edge of the clock (transition from EX to MEM)
    always_ff @(negedge clk or posedge rst) begin
        if (rst) begin
            // On reset, clear all pipeline registers to 0 (because it is a reset)
            ALUResultM <= 32'b0;
            WriteDataM <= 32'b0; 
            PCTargetM  <= 32'b0;
            rdM        <= 5'b0;
            PCPlus4M   <= 32'b0;
            funct3M    <= 3'b0;

            RegWriteM  <= 1'b0;
            ResultSrcM <= 2'b00;
            MemWriteM  <= 1'b0;
        end
        else if (!stall) begin  // Only update when not stalled
            // Normal operation: transfer data from EX stage to the MEM stage
            // We use the <= (non-blocking assignment) to ensure all registers update in parallel
            
            // Pass Data
            ALUResultM <= ALUResultE;
            WriteDataM <= WriteDataE;
            PCTargetM  <= PCTargetE;
            rdM        <= rdE;
            PCPlus4M   <= PCPlus4E;
            funct3M    <= funct3E;

            // Pass Control
            RegWriteM  <= RegWriteE;
            ResultSrcM <= ResultSrcE;
            MemWriteM  <= MemWriteE;
        end
        // else: stall - hold current values
    end

endmodule

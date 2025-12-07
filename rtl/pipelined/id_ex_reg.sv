module id_ex_reg (
    input  logic        clk,
    input  logic        rst,
    input  logic        flush,        // ID_EX_Flush from hazard_unit (1=insert bubble)
    
    // Control signals from ID stage (from control_unit)
    input  logic        RegWriteD,
    input  logic        MemWriteD,
    input  logic        MemReadD,
    input  logic        BranchD,
    input  logic        JumpD,
    input  logic        JalrD,
    input  logic        ALUSrcD,
    input  logic [1:0]  ResultSrcD,
    input  logic [2:0]  ALUControlD,
    
    // Data signals from ID stage
    input  logic [31:0] pcD,           // PC value
    input  logic [31:0] rs1_dataD,     // Data read from register rs1
    input  logic [31:0] rs2_dataD,     // Data read from register rs2
    input  logic [31:0] ImmExtD,       // Extended immediate
    input  logic [4:0]  rdD,           // Destination register address
    input  logic [4:0]  rs1_addrD,     // Source register 1 address
    input  logic [4:0]  rs2_addrD,     // Source register 2 address
    input  logic [2:0]  funct3D,       // Function code for memory ops
    input  logic [31:0] PCPlus4D,      // PC+4 from IF stage
    
    // Control outputs to EX stage
    output logic        RegWriteE,
    output logic        MemWriteE,
    output logic        MemReadE,
    output logic        BranchE,
    output logic        JumpE,
    output logic        JalrE,
    output logic        ALUSrcE,
    output logic [1:0]  ResultSrcE,
    output logic [2:0]  ALUControlE,
    
    // Data outputs to EX stage
    output logic [31:0] pcE,
    output logic [31:0] rs1_dataE,
    output logic [31:0] rs2_dataE,
    output logic [31:0] ImmExtE,
    output logic [4:0]  rdE,
    output logic [4:0]  rs1_addrE,
    output logic [4:0]  rs2_addrE,
    output logic [2:0]  funct3E,
    output logic [31:0] PCPlus4E
);

    always_ff @(negedge clk or posedge rst) begin
        if (rst) begin
            // On reset, clear all control and data signals
            RegWriteE    <= 1'b0;
            MemWriteE    <= 1'b0;
            MemReadE     <= 1'b0;
            BranchE      <= 1'b0;
            JumpE        <= 1'b0;
            JalrE        <= 1'b0;
            ALUSrcE      <= 1'b0;
            ResultSrcE   <= 2'b00;
            ALUControlE  <= 3'b000;
            
            pcE          <= 32'b0;
            rs1_dataE    <= 32'b0;
            rs2_dataE    <= 32'b0;
            ImmExtE      <= 32'b0;
            rdE          <= 5'b0;
            rs1_addrE    <= 5'b0;
            rs2_addrE    <= 5'b0;
            funct3E      <= 3'b0;
            PCPlus4E     <= 32'b0;
        end 
        else if (flush) begin
            // Insert a bubble: zero ONLY the control bits
            // This creates a NOP in the EX stage (no writes, no branches, no jumps)
            RegWriteE    <= 1'b0;
            MemWriteE    <= 1'b0;
            MemReadE     <= 1'b0;
            BranchE      <= 1'b0;
            JumpE        <= 1'b0;
            JalrE        <= 1'b0;
            ALUSrcE      <= 1'b0;
            ResultSrcE   <= 2'b00;
            ALUControlE  <= 3'b000;
            
            // Zero rdE to prevent forwarding from flushed instruction
            rdE          <= 5'b0;
            
            // Data values can be kept (they won't be used since control bits are zero)
            // But for cleanliness, we could zero them too
            pcE          <= pcD;
            rs1_dataE    <= rs1_dataD;
            rs2_dataE    <= rs2_dataD;
            ImmExtE      <= ImmExtD;
            //rdE          <= rdD;
            rs1_addrE    <= rs1_addrD;
            rs2_addrE    <= rs2_addrD;
            funct3E      <= funct3D;
            PCPlus4E     <= PCPlus4D;
        end 
        else begin
            // Normal operation: pass all control and data from ID to EX
            RegWriteE    <= RegWriteD;
            MemWriteE    <= MemWriteD;
            MemReadE     <= MemReadD;
            BranchE      <= BranchD;
            JumpE        <= JumpD;
            JalrE        <= JalrD;
            ALUSrcE      <= ALUSrcD;
            ResultSrcE   <= ResultSrcD;
            ALUControlE  <= ALUControlD;
            
            pcE          <= pcD;
            rs1_dataE    <= rs1_dataD;
            rs2_dataE    <= rs2_dataD;
            ImmExtE      <= ImmExtD;
            rdE          <= rdD;
            rs1_addrE    <= rs1_addrD;
            rs2_addrE    <= rs2_addrD;
            funct3E      <= funct3D;
            PCPlus4E     <= PCPlus4D;
        end
    end

endmodule

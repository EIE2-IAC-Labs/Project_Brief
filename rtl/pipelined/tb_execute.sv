// This file is simply a testing. It's just to prove that the forwarding logic is functional.
// The goal is to prove that when ForwardAE is 10, the ALU ignores rs1 and uses ALUResultM instead. 

module tb_execute;

    logic clk;

    // Inputs
    logic ALUSrcE;
    logic [2:0] ALUControlE;
    logic [31:0] rs1_dataE, rs2_dataE, ImmExtE, PCE;
    logic [1:0] ForwardAE, ForwardBE;     // 2-bit signals matching execute.sv
    logic [31:0] ALUResultM, ResultW;

    // Outputs
    logic [31:0] ALUResultE, WriteDataE, PCTargetE;
    logic cond_trueE;

    // Instantiate the Device Under Test
    execute dut (
        .clk(clk),
        .ALUSrcE(ALUSrcE),
        .ALUControlE(ALUControlE),
        .rs1_dataE(rs1_dataE),
        .rs2_dataE(rs2_dataE),
        .ImmExtE(ImmExtE),
        .PCE(PCE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .ALUResultM(ALUResultM),
        .ResultW(ResultW),
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .PCTargetE(PCTargetE),
        .cond_trueE(cond_trueE)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test Procedure
    initial begin
        $display("--- Starting Execute Stage + Forwarding Test ---");

        // Initialize Defaults
        ALUSrcE = 0;        // Use Register Data (not Immediate)
        ALUControlE = 3'b000; // ADD Operation
        PCE = 32'd0;
        ImmExtE = 32'd0;
        
        // ============================================================
        // TEST CASE 1: No Forwarding (Standard ADD)
        // Operation: 10 + 20
        // Expected: 30
        // ============================================================
        rs1_dataE = 32'd10; 
        rs2_dataE = 32'd20;
        ForwardAE = 2'b00; // Select rs1_dataE
        ForwardBE = 2'b00; // Select rs2_dataE
        
        #10; // Wait 10 time units
        
        if (ALUResultE === 32'd30) 
            $display("PASS: Test 1 (No Forwarding) -> Result: %d", ALUResultE);
        else 
            $display("FAIL: Test 1. Expected 30, got %d", ALUResultE);


        // ============================================================
        // TEST CASE 2: Forwarding SrcA from Memory (Hazard A)
        // Operation: 100 (Forwarded from MEM) + 20 (Reg)
        // Expected: 120
        // ============================================================
        ALUResultM = 32'd100; // Simulate data sitting in EX/MEM register
        ForwardAE = 2'b10;    // Tell Mux to grab from ALUResultM
        ForwardBE = 2'b00;    // Standard SrcB
        
        #10;
        
        if (ALUResultE === 32'd120) 
            $display("PASS: Test 2 (Forwarding SrcA from MEM) -> Result: %d", ALUResultE);
        else 
            $display("FAIL: Test 2. Expected 120, got %d", ALUResultE);


        // ============================================================
        // TEST CASE 3: Forwarding SrcB from Writeback (Hazard B)
        // Operation: 10 (Reg) + 50 (Forwarded from WB)
        // Expected: 60
        // ============================================================
        ResultW = 32'd50;     // Simulate data sitting in MEM/WB register
        ForwardAE = 2'b00;    // Reset SrcA to normal
        ForwardBE = 2'b01;    // Tell Mux to grab from ResultW
        
        #10;
        
        if (ALUResultE === 32'd60) 
            $display("PASS: Test 3 (Forwarding SrcB from WB) -> Result: %d", ALUResultE);
        else 
            $display("FAIL: Test 3. Expected 60, got %d", ALUResultE);


        // ============================================================
        // TEST CASE 4: Branch Decision (BNE)
        // Control: 001 (BNE)
        // Inputs: 5 and 5 (Equal)
        // Expected: cond_trueE should be 0 (False, because they ARE equal)
        // ============================================================
        ALUControlE = 3'b001; // BNE
        rs1_dataE = 32'd5;
        rs2_dataE = 32'd5;
        ForwardAE = 2'b00;
        ForwardBE = 2'b00;

        #10;

        if (cond_trueE === 1'b0)
            $display("PASS: Test 4 (BNE Not Taken) -> cond_trueE: %b", cond_trueE);
        else
            $display("FAIL: Test 4. Expected cond_trueE=0, got %b", cond_trueE);

        $finish;
    end

endmodule



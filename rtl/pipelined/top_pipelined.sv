// Top-level pipelined RISC-V processor
// Integrates all pipeline stages, registers, hazard detection, and forwarding

module top_pipelined (
    input  logic        clk,
    input  logic        rst,
    input  logic        trigger,     // Trigger input (for VBuddy, unused in pipelined)
    output logic [31:0] a0           // Register a0 output for testbench
);

    // IF Stage Signals
    logic [31:0] pcF;                
    logic [31:0] instrF;             
    logic [31:0] PCPlus4F;           
    logic [31:0] pc_next;            
    
    //IF/ID Pipeline Register Signals 
    logic [31:0] pcD;                
    logic [31:0] instrD;    
    logic [31:0] PCPlus4D;
      
    
    // ID Stage Signals 
    logic [31:0] rs1_dataD;          
    logic [31:0] rs2_dataD;          
    logic [31:0] ImmExtD;            
    logic [4:0]  rs1_addrD;          
    logic [4:0]  rs2_addrD;          
    logic [4:0]  rdD;
    logic [2:0]  funct3D;            // Need funct3 for memory operations
    
    // Control signals from control_unit in ID
    logic        RegWriteD;
    logic        MemWriteD;
    logic        MemReadD;
    logic        BranchD;
    logic        JumpD;
    logic        JalrD;
    logic        ALUSrcD;
    logic [1:0]  ResultSrcD;
    logic [3:0]  ALUControlD;
    logic [2:0]  ImmSrcD;
    
    //ID/EX Pipeline Register Signals
    logic [31:0] pcE;
    logic [31:0] rs1_dataE;
    logic [31:0] rs2_dataE;
    logic [31:0] ImmExtE;
    logic [4:0]  rdE;
    logic [4:0]  rs1_addrE;
    logic [4:0]  rs2_addrE;
    logic [2:0]  funct3E;            // funct3 in EX stage
    
    logic        RegWriteE;
    logic        MemWriteE;
    logic        MemReadE;
    logic        BranchE;
    logic        JumpE;
    logic        JalrE;
    logic        ALUSrcE;
    logic [1:0]  ResultSrcE;
    logic [3:0]  ALUControlE;
    
    // EX Stage Signals 
    logic [31:0] ALUResultE;         
    logic [31:0] WriteDataE;         
    logic [31:0] PCTargetE;          
    logic [31:0] PCPlus4E;           
    logic [31:0] PCJalrE;            
    logic        cond_trueE;         
    
    // Forwarding control signals
    logic [1:0]  ForwardAE;
    logic [1:0]  ForwardBE;
    
    // EX/MEM Pipeline Register Signals 
    logic [31:0] ALUResultM;
    logic [31:0] WriteDataM;
    logic [31:0] PCTargetM;
    logic [31:0] PCPlus4M;
    logic [4:0]  rdM;
    logic [2:0]  funct3M;            // funct3 in MEM stage
    
    logic        RegWriteM;
    logic [1:0]  ResultSrcM;
    logic        MemWriteM;

    
    // MEM Stage Signals 
    logic [31:0] ReadDataM;
    logic [31:0] ForwardDataM;      // Muxed data to forward from MEM stage
    logic        CacheStall;        // stall signal from data cache
    logic        MemReadM;

    // Loads have ResultSrcM == 2'b01 (memory result)
    assign MemReadM = (ResultSrcM == 2'b01);
    
    // MEM/WB Pipeline Register Signals 
    logic [31:0] ALUResultW;
    logic [31:0] ReadDataW;
    logic [31:0] PCPlus4W;
    logic [4:0]  rdW;
    
    logic        RegWriteW;
    logic [1:0]  ResultSrcW;
    
    //WB Stage Signals 
    logic [31:0] ResultW;           
    
    // Hazard Control Signals 
    logic        PCWrite;            
    logic        IF_ID_Write;        
    logic        IF_ID_Flush;        
    logic        ID_EX_Flush;        
    
    // IF STAGE - Instruction Fetch
    
    pc_reg_pipe pc_reg_inst (
        .clk(clk),
        .rst(rst),
        .en(PCWrite),            // Controlled by hazard unit
        .pc_next(pc_next),
        .pc(pcF)
    );
    

    assign PCPlus4F = pcF + 32'd4;
    
    // PC next logic (handles branches, jumps, and JALR)
    assign PCJalrE = {ALUResultE[31:1], 1'b0};  
    
    always_comb begin
        if (JalrE)
            pc_next = PCJalrE;               // JALR: jump to (rs1+imm) & ~1
        else if (BranchE && cond_trueE)
            pc_next = PCTargetE;             // Branch taken: jump to PC+imm
        else if (JumpE)
            pc_next = PCTargetE;             // JAL: jump to PC+imm
        else
            pc_next = PCPlus4F;              // Normal: PC = PC + 4
    end
    
    // Instruction Memory
    instr_mem instr_mem_inst (
        .addr_i(pcF),
        .instr_o(instrF)
    );
    

    
        // IF/ID Pipeline Register
    if_id_reg if_id_reg_inst (
        .clk(clk),
        .rst(rst),
        .write_enable(IF_ID_Write),
        .flush(IF_ID_Flush),
        .pcF(pcF),
        .instrF(instrF),
        .pcD(pcD),
        .instrD(instrD)
    );

    // PC+4 for the instruction currently in ID
    assign PCPlus4D = pcD + 32'd4;

    
    // ID STAGE - Instruction Decode

    // Extract instruction fields
    assign rs1_addrD = instrD[19:15];
    assign rs2_addrD = instrD[24:20];
    assign rdD       = instrD[11:7];
    assign funct3D   = instrD[14:12];  // Extract funct3 for memory ops
    
    
    control_unit control_unit_inst (
        .opcode(instrD[6:0]),
        .funct3(instrD[14:12]),
        .funct7(instrD[31:25]),
        .RegWrite(RegWriteD),
        .MemWrite(MemWriteD),
        .MemRead(MemReadD),
        .ALUSrc(ALUSrcD),
        .Branch(BranchD),
        .Jump(JumpD),
        .Jalr(JalrD),
        .ImmSrc(ImmSrcD),
        .ResultSrc(ResultSrcD),
        .ALUControl(ALUControlD)
    );
    
   
    register_file register_file_inst (
        .clk(clk),
        .rst(rst),
        .WE3(RegWriteW),         // Write back from WB stage
        .A1(rs1_addrD),
        .A2(rs2_addrD),
        .A3(rdW),                // Write address from WB stage
        .WD3(ResultW),           // Write data from WB stage
        .RD1(rs1_dataD),
        .RD2(rs2_dataD),
        .a0(a0)
    );
    
    // Immediate Extension
    extend extend_inst (
        .instr(instrD),
        .ImmSrc(ImmSrcD),
        .ImmExt(ImmExtD)
    );
    
    
    
    // ID/EX Pipeline Register
    
    id_ex_reg id_ex_reg_inst (
        .clk(clk),
        .rst(rst),
        .flush(ID_EX_Flush),
        .stall(CacheStall),  // ADD THIS
        
        // Control inputs
        .RegWriteD(RegWriteD),
        .MemWriteD(MemWriteD),
        .MemReadD(MemReadD),
        .BranchD(BranchD),
        .JumpD(JumpD),
        .JalrD(JalrD),
        .ALUSrcD(ALUSrcD),
        .ResultSrcD(ResultSrcD),
        .ALUControlD(ALUControlD),
        
        // Data inputs
        .pcD(pcD),
        .rs1_dataD(rs1_dataD),
        .rs2_dataD(rs2_dataD),
        .ImmExtD(ImmExtD),
        .rdD(rdD),
        .rs1_addrD(rs1_addrD),
        .rs2_addrD(rs2_addrD),
        .funct3D(funct3D),
        .PCPlus4D(PCPlus4D),
        
        // Control outputs
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .MemReadE(MemReadE),
        .BranchE(BranchE),
        .JumpE(JumpE),
        .JalrE(JalrE),
        .ALUSrcE(ALUSrcE),
        .ResultSrcE(ResultSrcE),
        .ALUControlE(ALUControlE),
        
        // Data outputs
        .pcE(pcE),
        .rs1_dataE(rs1_dataE),
        .rs2_dataE(rs2_dataE),
        .ImmExtE(ImmExtE),
        .rdE(rdE),
        .rs1_addrE(rs1_addrE),
        .rs2_addrE(rs2_addrE),
        .funct3E(funct3E),       // Output funct3
        .PCPlus4E(PCPlus4E) 
    );
    
    
    
    // EX STAGE - Execute
    
    
    // Execute module (includes ALU, forwarding muxes, and branch condition logic)
    execute execute_inst (
        .ALUSrcE(ALUSrcE),
        .ALUControlE(ALUControlE),
        .rs1_dataE(rs1_dataE),
        .rs2_dataE(rs2_dataE),
        .ImmExtE(ImmExtE),
        .PCE(pcE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .ALUResultM(ForwardDataM),   // Forward muxed data from MEM stage
        .ResultW(ResultW),
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .PCTargetE(PCTargetE),
        .cond_trueE(cond_trueE),
        .funct3E(funct3E)
    );
    
    
    // EX/MEM Pipeline Register

    exe_mem_reg exe_mem_reg_inst (
        .clk(clk),
        .rst(rst),
        .stall(CacheStall),  // ADD THIS
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .PCTargetE(PCTargetE),
        .rdE(rdE),
        .PCPlus4E(PCPlus4E),
        .funct3E(funct3E),       // Pass funct3 to MEM stage
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .PCTargetM(PCTargetM),
        .rdM(rdM),
        .PCPlus4M(PCPlus4M),
        .funct3M(funct3M),       // Output funct3
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM)
    );
    
    
    // MEM STAGE - Memory Access (via Data Cache)
    data_cache data_cache_inst (
        .clk       (clk),
        .rst       (rst),

        // CPU-side (from EX/MEM stage)
        .cpu_req   (MemReadM | MemWriteM),
        .cpu_we    (MemWriteM),              // 1 = store
        .cpu_addr  (ALUResultM),             // byte address
        .cpu_wdata (WriteDataM),
        .cpu_funct3(funct3M),
        .cpu_rdata (ReadDataM),              // load result to MEM/WB
        .cpu_stall (CacheStall)              // stall signal for hazard unit
    );

    
    // MUX to select correct data to forward from MEM stage
    // When forwarding from MEM, we need what would be written back:
    // - ALU result
    // - Memory data
    // - PC+4 (for JAL/JALR)
    always_comb begin
        case (ResultSrcM)
            2'b00:   ForwardDataM = ALUResultM;   // ALU result
            2'b01:   ForwardDataM = ReadDataM;    // Memory data (now comes from cache wrapper)
            2'b10:   ForwardDataM = PCPlus4M;     // PC+4 (for JAL/JALR)
            default: ForwardDataM = ALUResultM;
        endcase
    end
    

    // MEM/WB Pipeline Register
    
    mem_wb_reg mem_wb_reg_inst (
        .clk(clk),
        .rst(rst),
        .stall(CacheStall),  // ADD THIS
        .ALUResultM(ALUResultM),
        .ReadDataM(ReadDataM),
        .PCPlus4M(PCPlus4M),
        .rdM(rdM),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .PCPlus4W(PCPlus4W),
        .rdW(rdW),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW)
    );
    
    
    // WB STAGE - Write Back
    
    // Result multiplexer
    always_comb begin
        case (ResultSrcW)
            2'b00:   ResultW = ALUResultW;   // ALU result
            2'b01:   ResultW = ReadDataW;    // Memory data (load)
            2'b10:   ResultW = PCPlus4W;     // PC+4 (JAL/JALR)
            default: ResultW = ALUResultW;
        endcase
    end
    
    
    // Hazard Detection Unit
    
    hazard_unit hazard_unit_inst (
        .rs1D(rs1_addrD),
        .rs2D(rs2_addrD),
        .rdE(rdE),
        .MemReadE(MemReadE),
        .BranchE(BranchE),
        .JumpE(JumpE),
        .JalrE(JalrE),
        .cond_trueE(cond_trueE),
        .CacheStall (CacheStall),
        .PCWrite(PCWrite),
        .IF_ID_Write(IF_ID_Write),
        .IF_ID_Flush(IF_ID_Flush),
        .ID_EX_Flush(ID_EX_Flush)
    );
    
    
    // Forwarding Unit
    
    forward_unit forward_unit_inst (
        .rs1E(rs1_addrE),
        .rs2E(rs2_addrE),
        .rdM(rdM),
        .RegWriteM(RegWriteM),
        .rdW(rdW),
        .RegWriteW(RegWriteW),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

endmodule

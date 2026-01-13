
module top_superscalar (
    input  logic        clk,
    input  logic        rst,
    input  logic        trigger,
    output logic [31:0] a0
);

    // IF stage: dual fetch

    logic [31:0] pcF;
    logic [31:0] pc_next;
    logic [31:0] PCPlus4F;

    logic [31:0] instr0F;   // slot 0: PC
    logic [31:0] instr1F;   // slot 1: PC+4

    // PC register (unchanged)
    logic PCWrite;

    pc_reg_pipe pc_reg_inst (
        .clk    (clk),
        .rst    (rst),
        .en     (PCWrite),
        .pc_next(pc_next),
        .pc     (pcF)
    );

    assign PCPlus4F = pcF + 32'd4;

    // Dual-port instruction memory: fetch [pc] and [pc+4]
    instr_mem_dual instr_mem_dual_inst (
        .addr0_i (pcF),
        .addr1_i (PCPlus4F),
        .instr0_o(instr0F),
        .instr1_o(instr1F)
    );

    // IF/ID pipeline register (dual instruction)

    logic [31:0] pcD;
    logic [31:0] instr0D;
    logic [31:0] instr1D;

    logic IF_ID_Write;
    logic IF_ID_Flush;

    if_id_reg_dual if_id_reg_inst (
        .clk         (clk),
        .rst         (rst),
        .write_enable(IF_ID_Write),
        .flush       (IF_ID_Flush),
        .pcF         (pcF),
        .instr0F     (instr0F),
        .instr1F     (instr1F),
        .pcD         (pcD),
        .instr0D     (instr0D),
        .instr1D     (instr1D)
    );

    // ID stage:

    // Slot 0 (the existing pipeline)

    logic [4:0] rs1_addrD;
    logic [4:0] rs2_addrD;
    logic [4:0] rdD;
    logic [2:0] funct3D;
    logic [31:0] rs1_dataD;
    logic [31:0] rs2_dataD;
    logic [31:0] ImmExtD;

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

    assign rs1_addrD = instr0D[19:15];
    assign rs2_addrD = instr0D[24:20];
    assign rdD       = instr0D[11:7];
    assign funct3D   = instr0D[14:12];

    // Main control unit (unchanged, for slot 0)
    control_unit control0_inst (
        .opcode    (instr0D[6:0]),
        .funct3    (instr0D[14:12]),
        .funct7    (instr0D[31:25]),
        .RegWrite  (RegWriteD),
        .MemWrite  (MemWriteD),
        .MemRead   (MemReadD),
        .ALUSrc    (ALUSrcD),
        .Branch    (BranchD),
        .Jump      (JumpD),
        .Jalr      (JalrD),
        .ImmSrc    (ImmSrcD),
        .ResultSrc (ResultSrcD),
        .ALUControl(ALUControlD)
    );

    // Register file (single write port, as before)
    logic [4:0]  rdW;
    logic [31:0] ResultW;
    logic        RegWriteW;

    register_file register_file_inst (
        .clk (clk),
        .rst (rst),
        .WE3 (RegWriteW),
        .A1  (rs1_addrD),
        .A2  (rs2_addrD),
        .A3  (rdW),
        .WD3 (ResultW),
        .RD1 (rs1_dataD),
        .RD2 (rs2_dataD),
        .a0  (a0)
    );

    // Immediate extension for slot 0
    extend extend_inst (
        .instr  (instr0D),
        .ImmSrc (ImmSrcD),
        .ImmExt (ImmExtD)
    );

    // Slot 1 (preview)

    logic [4:0] rs1_addr1D;
    logic [4:0] rs2_addr1D;
    logic [4:0] rd1D;
    logic [2:0] funct3_1D;

    // Basic fields from instr1D
    assign rs1_addr1D = instr1D[19:15];
    assign rs2_addr1D = instr1D[24:20];
    assign rd1D       = instr1D[11:7];
    assign funct3_1D  = instr1D[14:12];

    logic        RegWrite1D;
    logic        MemWrite1D;
    logic        MemRead1D;
    logic        Branch1D;
    logic        Jump1D;
    logic        Jalr1D;
    logic        ALUSrc1D;
    logic [1:0]  ResultSrc1D;
    logic [3:0]  ALUControl1D;
    logic [2:0]  ImmSrc1D;

    // A second control_unit for slot 1, used only for classification
    control_unit control1_inst (
        .opcode    (instr1D[6:0]),
        .funct3    (instr1D[14:12]),
        .funct7    (instr1D[31:25]),
        .RegWrite  (RegWrite1D),
        .MemWrite  (MemWrite1D),
        .MemRead   (MemRead1D),
        .ALUSrc    (ALUSrc1D),
        .Branch    (Branch1D),
        .Jump      (Jump1D),
        .Jalr      (Jalr1D),
        .ImmSrc    (ImmSrc1D),
        .ResultSrc (ResultSrc1D),
        .ALUControl(ALUControl1D)
    );

    // Dual-issue decision

    logic issue0;
    logic issue1;

    dual_issue_unit issue_unit_inst (
        // slot 0
        .rs1_0      (rs1_addrD),
        .rs2_0      (rs2_addrD),
        .rd_0       (rdD),
        .is_load_0  (MemReadD),
        .is_store_0 (MemWriteD),
        .is_branch_0(BranchD),
        .is_jump_0  (JumpD | JalrD),

        // slot 1
        .rs1_1      (rs1_addr1D),
        .rs2_1      (rs2_addr1D),
        .rd_1       (rd1D),
        .is_load_1  (MemRead1D),
        .is_store_1 (MemWrite1D),
        .is_branch_1(Branch1D),
        .is_jump_1  (Jump1D | Jalr1D),

        .issue0     (issue0),
        .issue1     (issue1)
    );


    // ID/EX register and the rest of the single pipeline lane
    // (identical to top_pipelined.sv, driven from slot 0 signals)

    // ID/EX signals
    logic [31:0] pcE;
    logic [31:0] rs1_dataE;
    logic [31:0] rs2_dataE;
    logic [31:0] ImmExtE;
    logic [4:0]  rdE;
    logic [4:0]  rs1_addrE;
    logic [4:0]  rs2_addrE;
    logic [2:0]  funct3E;

    logic        RegWriteE;
    logic        MemWriteE;
    logic        MemReadE;
    logic        BranchE;
    logic        JumpE;
    logic        JalrE;
    logic        ALUSrcE;
    logic [1:0]  ResultSrcE;
    logic [3:0]  ALUControlE;

    logic [31:0] PCPlus4E;
    logic [31:0] PCTargetE;
    logic [31:0] PCJalrE;
    logic        cond_trueE;

    logic [1:0]  ForwardAE;
    logic [1:0]  ForwardBE;

    logic        ID_EX_Flush;

    logic CacheStall;

    // ID/EX register (unchanged)
    id_ex_reg id_ex_reg_inst (
        .clk        (clk),
        .rst        (rst),
        .stall      (CacheStall),
        .flush      (ID_EX_Flush),

        // control in
        .RegWriteD  (RegWriteD),
        .MemWriteD  (MemWriteD),
        .MemReadD   (MemReadD),
        .BranchD    (BranchD),
        .JumpD      (JumpD),
        .JalrD      (JalrD),
        .ALUSrcD    (ALUSrcD),
        .ResultSrcD (ResultSrcD),
        .ALUControlD(ALUControlD),

        // data in
        .pcD        (pcD),
        .rs1_dataD  (rs1_dataD),
        .rs2_dataD  (rs2_dataD),
        .ImmExtD    (ImmExtD),
        .rdD        (rdD),
        .rs1_addrD  (rs1_addrD),
        .rs2_addrD  (rs2_addrD),
        .funct3D    (funct3D),
        .PCPlus4D   (PCPlus4F),   // PC+4 from IF

        // control out
        .RegWriteE  (RegWriteE),
        .MemWriteE  (MemWriteE),
        .MemReadE   (MemReadE),
        .BranchE    (BranchE),
        .JumpE      (JumpE),
        .JalrE      (JalrE),
        .ALUSrcE    (ALUSrcE),
        .ResultSrcE (ResultSrcE),
        .ALUControlE(ALUControlE),

        // data out
        .pcE        (pcE),
        .rs1_dataE  (rs1_dataE),
        .rs2_dataE  (rs2_dataE),
        .ImmExtE    (ImmExtE),
        .rdE        (rdE),
        .rs1_addrE  (rs1_addrE),
        .rs2_addrE  (rs2_addrE),
        .funct3E    (funct3E),
        .PCPlus4E   (PCPlus4E)
    );

    // EX stage (unchanged)
    logic [31:0] ALUResultE;
    logic [31:0] WriteDataE;

    execute execute_inst (
        .clk         (clk),
        .ALUSrcE     (ALUSrcE),
        .ALUSrcAE    (1'b0),
        .ALUControlE (ALUControlE),
        .Funct3E     (funct3E),
        .JalrE       (JalrE),
        .rs1_dataE   (rs1_dataE),
        .rs2_dataE   (rs2_dataE),
        .ImmExtE     (ImmExtE),
        .PCE         (pcE),
        .ForwardAE   (ForwardAE),
        .ForwardBE   (ForwardBE),
        .ALUResultM  (ForwardDataM),
        .ResultW     (ResultW),
        .funct3E     (funct3E),
        .ALUResultE  (ALUResultE),
        .WriteDataE  (WriteDataE),
        .PCTargetE   (PCTargetE),
        .cond_trueE  (cond_trueE)
    );

    // PC next (branches/jumps resolved in EX, as before)
    assign PCJalrE = {ALUResultE[31:1], 1'b0};

    always_comb begin
        if (JalrE)
            pc_next = PCJalrE;
        else if (BranchE && cond_trueE)
            pc_next = PCTargetE;
        else if (JumpE)
            pc_next = PCTargetE;
        else
            pc_next = PCPlus4F;
    end

    // EX/MEM register
    logic [31:0] ALUResultM;
    logic [31:0] WriteDataM;
    logic [31:0] PCTargetM;
    logic [31:0] PCPlus4M;
    logic [4:0]  rdM;
    logic [2:0]  funct3M;

    logic        RegWriteM;
    logic [1:0]  ResultSrcM;
    logic        MemWriteM;

    exe_mem_reg exe_mem_reg_inst (
        .clk        (clk),
        .rst        (rst),
        .stall      (CacheStall),
        .ALUResultE (ALUResultE),
        .WriteDataE (WriteDataE),
        .PCTargetE  (PCTargetE),
        .rdE        (rdE),
        .PCPlus4E   (PCPlus4E),
        .funct3E    (funct3E),
        .RegWriteE  (RegWriteE),
        .ResultSrcE (ResultSrcE),
        .MemWriteE  (MemWriteE),
        .ALUResultM (ALUResultM),
        .WriteDataM (WriteDataM),
        .PCTargetM  (PCTargetM),
        .rdM        (rdM),
        .PCPlus4M   (PCPlus4M),
        .funct3M    (funct3M),
        .RegWriteM  (RegWriteM),
        .ResultSrcM (ResultSrcM),
        .MemWriteM  (MemWriteM)
    );

    // MEM stage with data cache
    logic [31:0] ReadDataM;
    logic [31:0] ForwardDataM;
    logic        MemReadM;

    assign MemReadM = (ResultSrcM == 2'b01);

    data_cache data_cache_inst (
        .clk       (clk),
        .rst       (rst),
        .cpu_req   (MemReadM | MemWriteM),
        .cpu_we    (MemWriteM),
        .cpu_addr  (ALUResultM),
        .cpu_wdata (WriteDataM),
        .cpu_funct3(funct3M),
        .cpu_rdata (ReadDataM),
        .cpu_stall (CacheStall)
    );

    always_comb begin
        case (ResultSrcM)
            2'b00:   ForwardDataM = ALUResultM;
            2'b01:   ForwardDataM = ReadDataM;
            2'b10:   ForwardDataM = PCPlus4M;
            default: ForwardDataM = ALUResultM;
        endcase
    end

    // MEM/WB register
    logic [31:0] ALUResultW;
    logic [31:0] ReadDataW;
    logic [31:0] PCPlus4W;

    mem_wb_reg mem_wb_reg_inst (
        .clk        (clk),
        .rst        (rst),
        .stall      (CacheStall),
        .ALUResultM (ALUResultM),
        .ReadDataM  (ReadDataM),
        .PCPlus4M   (PCPlus4M),
        .rdM        (rdM),
        .RegWriteM  (RegWriteM),
        .ResultSrcM (ResultSrcM),
        .ALUResultW (ALUResultW),
        .ReadDataW  (ReadDataW),
        .PCPlus4W   (PCPlus4W),
        .rdW        (rdW),
        .RegWriteW  (RegWriteW),
        .ResultSrcW (ResultSrcW)
    );

    // WB stage mux
    always_comb begin
        case (ResultSrcW)
            2'b00:   ResultW = ALUResultW;
            2'b01:   ResultW = ReadDataW;
            2'b10:   ResultW = PCPlus4W;
            default: ResultW = ALUResultW;
        endcase
    end

    // Hazard unit (still only aware of slot 0 pipeline)
    hazard_unit hazard_unit_inst (
        .rs1D       (rs1_addrD),
        .rs2D       (rs2_addrD),
        .rdE        (rdE),
        .MemReadE   (MemReadE),
        .BranchE    (BranchE),
        .JumpE      (JumpE),
        .JalrE      (JalrE),
        .cond_trueE (cond_trueE),
        .CacheStall (CacheStall),
        .PCWrite    (PCWrite),
        .IF_ID_Write(IF_ID_Write),
        .IF_ID_Flush(IF_ID_Flush),
        .ID_EX_Flush(ID_EX_Flush)
    );

    // Forwarding unit
    forward_unit forward_unit_inst (
        .rs1E     (rs1_addrE),
        .rs2E     (rs2_addrE),
        .rdM      (rdM),
        .RegWriteM(RegWriteM),
        .rdW      (rdW),
        .RegWriteW(RegWriteW),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

endmodule

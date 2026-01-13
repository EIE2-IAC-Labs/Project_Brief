// Hazard detection + control unit
// Handles:
//   - load-use data hazards (stall + bubble)
//   - control hazards (branch/jal/jalr taken in EX) (flush)

module hazard_unit (
    // Decode stage
    input  logic [4:0] rs1D,
    input  logic [4:0] rs2D,

    // Execute stage
    input  logic [4:0] rdE,
    input  logic       MemReadE,    // EX-stage instruction is a load
    input  logic       BranchE,     // EX-stage is branch
    input  logic       JumpE,       // EX-stage is jal
    input  logic       JalrE,       // EX-stage is jalr
    input  logic       cond_trueE,  // branch condition result (for bne/bgeu)

    // Cache stall signal (from MEM stage)
    input  logic       CacheStall,

    // Outputs to control pipeline registers + PC
    output logic       PCWrite,     //used in top_pipe.sv, enables pc_reg, if 0 → stall PC
    output logic       IF_ID_Write, //used in if_id_reg.sv (write_enable), 1 = IF/ID register updates, 0 = IF/ID register stalls
    output logic       IF_ID_Flush, //used in if_id_reg.sv (flush NOP), 1 = instruction in ID replaced with NOP
    output logic       ID_EX_Flush  //used in id_ex_reg.sv (flush bubble), 1 = insert bubble into EX stage (zero EX control bits)
);

    logic load_use_hazard;
    logic branch_takenE;


    always_comb begin
        // default: no stall, no flush
        PCWrite     = 1'b1;
        IF_ID_Write = 1'b1;
        IF_ID_Flush = 1'b0;
        ID_EX_Flush = 1'b0;

        load_use_hazard = 1'b0;
        branch_takenE   = (BranchE & cond_trueE) | JumpE | JalrE;

        // 1. Cache stall (Freeze IF and ID, do NOT flush)
        if (CacheStall) begin
            PCWrite     = 1'b0;
            IF_ID_Write = 1'b0;
        end
        else begin
            // 2. Load-use hazard
            if (MemReadE && (rdE != 5'd0) &&
               ((rdE == rs1D) || (rdE == rs2D))) begin
                load_use_hazard = 1'b1;
            end

            if (load_use_hazard) begin // Stall IF and ID, insert bubble in EX
                PCWrite     = 1'b0;
                IF_ID_Write = 1'b0;
                ID_EX_Flush = 1'b1;
            end

            // 3. Control hazard (branch / jal / jalr taken) (flush younger instructions)
            if (branch_takenE) begin
                IF_ID_Flush = 1'b1;
                ID_EX_Flush = 1'b1;
            end
        end
    end

endmodule

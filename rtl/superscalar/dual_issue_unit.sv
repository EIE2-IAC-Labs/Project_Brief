module dual_issue_unit (
    // Slot 0 
    input  logic [4:0] rs1_0,
    input  logic [4:0] rs2_0,
    input  logic [4:0] rd_0,
    input  logic       is_load_0,
    input  logic       is_store_0,
    input  logic       is_branch_0,
    input  logic       is_jump_0,

    // Slot 1 
    input  logic [4:0] rs1_1,
    input  logic [4:0] rs2_1,
    input  logic [4:0] rd_1,
    input  logic       is_load_1,
    input  logic       is_store_1,
    input  logic       is_branch_1,
    input  logic       is_jump_1,


    output logic       issue0,   // slot 0 is always considered issuable
    output logic       issue1    // 1 if slot 1 can be issued in parallel
);
    logic raw_0_to_1;
    logic waw_0_to_1;

    assign raw_0_to_1 = (rd_0 != 5'd0) &&
                        ((rd_0 == rs1_1) || (rd_0 == rs2_1));

    assign waw_0_to_1 = (rd_0 != 5'd0) &&
                        (rd_0 == rd_1);

    // only one branch/jump per cycle
    logic branch_or_jump_0, branch_or_jump_1;
    assign branch_or_jump_0 = is_branch_0 | is_jump_0;
    assign branch_or_jump_1 = is_branch_1 | is_jump_1;

    // at most one memory op per pair
    logic mem_0, mem_1, both_mem;
    assign mem_0   = is_load_0  | is_store_0;
    assign mem_1   = is_load_1  | is_store_1;
    assign both_mem = mem_0 & mem_1;

    always_comb begin
        // always: slot 0 issuable
        issue0 = 1'b1;

        // Slot 1 issuable only when no: RAW/WAW from slot0, branch/jump in either slot, two memory ops in the same pair
        if (raw_0_to_1   ||
            waw_0_to_1   ||
            branch_or_jump_0 ||
            branch_or_jump_1 ||
            both_mem)
            issue1 = 1'b0;
        else
            issue1 = 1'b1;
    end
endmodule


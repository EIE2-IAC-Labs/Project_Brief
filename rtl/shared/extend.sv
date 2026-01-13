module extend (
    input  logic [31:0] instr,
    input  logic [2:0]  ImmSrc,   // 000=I, 001=S, 010=B, 011=U, 100=J
    output logic [31:0] ImmExt
);
    logic [31:0] imm_i;   // I-type  (add, addi, lbu, jalr)
    logic [31:0] imm_s;   // S-type  (sb)
    logic [31:0] imm_b;   // B-type  (bne, bgeu)
    logic [31:0] imm_u;   // U-type  (lui)
    logic [31:0] imm_j;   // J-type  (jal)

    // I-type imm[11:0] = instr[31:20] sign-extended
    assign imm_i = {{20{instr[31]}}, instr[31:20]};

    // S-type imm[11:5] = instr[31:25], imm[4:0] = instr[11:7]
    assign imm_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};

    // B-type imm[12]= instr[31], imm[11]= instr[7], imm[10:5]= instr[30:25], imm[4:1]= instr[11:8], imm[0]= always 0
    logic [12:0] imm_b_raw; //reconstructed immediate before sign extension
    assign imm_b_raw = {
        instr[31],
        instr[7],
        instr[30:25],
        instr[11:8],
        1'b0 // always 0 because branch targets are word-aligned, even addresses (imm<<1)
    };
    assign imm_b = {{19{imm_b_raw[12]}}, imm_b_raw};

    // U-type imm[31:12] = instr[31:12], imm[11:0] = 0 (immediate shifted left by 12)
    assign imm_u = {instr[31:12], 12'b0};

    // J-type, PC+4 or PC+ offset(<<1)
    // imm[20]= instr[31], imm[10:1]= instr[30:21], imm[11]= instr[20], imm[19:12]= instr[19:12], imm[0]= always 0
    logic [20:0] imm_j_raw;
    assign imm_j_raw = {
        instr[31],
        instr[19:12],
        instr[20],
        instr[30:21],
        1'b0 //offset << 1
    };
    assign imm_j = {{11{imm_j_raw[20]}}, imm_j_raw};

   always_comb begin
    unique case (ImmSrc)
        3'b000: ImmExt = imm_i; 
        3'b001: ImmExt = imm_s; 
        3'b010: ImmExt = imm_b; 
        3'b011: ImmExt = imm_u; 
        3'b100: ImmExt = imm_j;
        default: ImmExt = 32'b0;
    endcase
end


endmodule

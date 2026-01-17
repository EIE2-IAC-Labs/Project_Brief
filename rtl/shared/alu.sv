module alu (
    input  logic [3:0]  ALUControl,  // widened to 4 bits for full RV321 design
    input  logic [31:0] SrcA,
    input  logic [31:0] SrcB,
    output logic        Zero,
    output logic [31:0] ALUResult
);

    localparam [3:0]
        ALU_ADD    = 4'b0000,
        ALU_SUB    = 4'b0001,
        ALU_PASS_B = 4'b0010,   // used for LUI
        ALU_SLTU   = 4'b0011,   // unsigned comparison
        ALU_SLT    = 4'b0100,   // signed comparison
        ALU_XOR    = 4'b0101,
        ALU_OR     = 4'b0110,
        ALU_AND    = 4'b0111,
        ALU_SLL    = 4'b1000,
        ALU_SRL    = 4'b1001,
        ALU_SRA    = 4'b1010;

    logic [31:0] sum;
    logic [31:0] diff;
    
    //Pre-calculate sum and diff to keep the logic clean
    assign sum = SrcA + SrcB;
    assign diff = SrcA - SrcB;

    always_comb begin
        unique case (ALUControl)
            ALU_ADD:    ALUResult = sum;
            ALU_SUB:    ALUResult = diff;
            ALU_PASS_B: ALUResult = SrcB;

            // comparisons
            ALU_SLTU:   ALUResult = (SrcA <  SrcB) ? 32'd1 : 32'd0;                // unsigned
            ALU_SLT:    ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 32'd1 : 32'd0;

            // bitwise
            ALU_XOR:    ALUResult = SrcA ^ SrcB;
            ALU_OR:     ALUResult = SrcA | SrcB;
            ALU_AND:    ALUResult = SrcA & SrcB;

            // shifts: RV32I uses only lower 5 bits of shift amount
            ALU_SLL:    ALUResult = SrcA <<  SrcB[4:0];
            ALU_SRL:    ALUResult = SrcA >>  SrcB[4:0];
            ALU_SRA:    ALUResult = $signed(SrcA) >>> SrcB[4:0];

            default:    ALUResult = 32'd0;
        endcase
    end


    //Zero flag is high if result is exactly zero (Obviously)
    assign Zero = (ALUResult == 32'b0);

endmodule

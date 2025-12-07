module alu (
    input logic [2:0] ALUControl,
    input logic [31:0] SrcA,
    input logic [31:0] SrcB,
    output logic       Zero,
    output logic [31:0] ALUResult
);

    logic [31:0] sum;
    logic [31:0] diff;
    
    //Pre-calculate sum and diff to keep the logic clean
    assign sum = SrcA + SrcB;
    assign diff = SrcA - SrcB;

    always_comb begin
        case (ALUControl) //Depending on the 3 bit ALUControl from the control unit
            3'b000: ALUResult = sum;          //ADD (add, load, store, etc)
            3'b001: ALUResult = diff;         //SUB
            3'b010: ALUResult = SrcB;         //PASS B (lui instruction)
            3'b011: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0; //SLTU (set less than if unsigned/set less than unsigned)
            default: ALUResult = 32'b0;        //Default case
        endcase
    end

    //Zero flag is high if result is exactly zero (Obviously)
    assign Zero = (ALUResult == 32'b0);

endmodule

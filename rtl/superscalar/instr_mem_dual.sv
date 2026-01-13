module instr_mem_dual #(
    parameter ADDRESS_WIDTH = 32,
              DATA_WIDTH    = 8,
              OUT_WIDTH     = 32
)(
    input  logic [ADDRESS_WIDTH-1:0] addr0_i,
    input  logic [ADDRESS_WIDTH-1:0] addr1_i,
    output logic [OUT_WIDTH-1:0]     instr0_o,
    output logic [OUT_WIDTH-1:0]     instr1_o
);
    logic [DATA_WIDTH-1:0] rom_array [0:4095];

    initial begin
        $readmemh("program.hex", rom_array);
    end

    logic [31:0] offset0, offset1;
    assign offset0 = addr0_i - 32'hBFC0_0000;
    assign offset1 = addr1_i - 32'hBFC0_0000;

    always_comb begin
        instr0_o = { rom_array[offset0+3], rom_array[offset0+2],
                     rom_array[offset0+1], rom_array[offset0+0] };
        instr1_o = { rom_array[offset1+3], rom_array[offset1+2],
                     rom_array[offset1+1], rom_array[offset1+0] };
    end
endmodule

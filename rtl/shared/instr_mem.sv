module instr_mem #(
    parameter ADDRESS_WIDTH = 32,
              DATA_WIDTH = 8,
              OUT_WIDTH = 32
)(
    input logic     [ADDRESS_WIDTH-1:0] addr_i,
    output logic    [OUT_WIDTH-1:0] instr_o
);

    // Byte-addressable memory - to match program.hex format
    logic [DATA_WIDTH-1:0] rom_array [0:4095]; // 4KB of byte-addressable memory
    
    initial begin
        $readmemh("program.hex", rom_array); 
    end
    
    // Calculate offset from base address
    logic [31:0] offset_addr;
    assign offset_addr = addr_i - 32'hBFC00000;
    
    // Assemble 32-bit instruction from 4 bytes - little-endian
    always_comb begin
        instr_o = {rom_array[offset_addr+3], rom_array[offset_addr+2], 
                   rom_array[offset_addr+1], rom_array[offset_addr+0]};
    end

endmodule

module data_mem #(
    parameter DATA_WIDTH = 32,  // Data width
    parameter ADDR_WIDTH = 17   // 128KB data memory (2^17 bytes)
)(
    input  logic                     clk,
    input  logic [DATA_WIDTH-1:0]    addr_i,
    input  logic [DATA_WIDTH-1:0]    write_data_i,
    input  logic                     write_en_i,
    input  logic [2:0]               funct3_i,
    output logic [DATA_WIDTH-1:0]    read_data_o
);

    // Memory array: byte-addressable, 128KB
    logic [7:0] ram_array [0:2**ADDR_WIDTH-1];
    
    initial begin
        // // Load data for PDF program at offset 0x10000
        $readmemh("data.hex", ram_array, 17'h10000);
    end
    
    // Extract byte address (lower 17 bits)
    logic [ADDR_WIDTH-1:0] byte_addr;
    assign byte_addr = addr_i[ADDR_WIDTH-1:0];
    
    // SYNCHRONOUS WRITE LOGIC
    always_ff @(posedge clk) begin
        if (write_en_i && funct3_i == 3'b000) begin  // SB only
            ram_array[byte_addr] <= write_data_i[7:0];
        end
    end
    
    
    // ASYNCHRONOUS READ LOGIC  
    always_comb begin
        if (funct3_i == 3'b100) begin  // LBU only
            read_data_o = {24'b0, ram_array[byte_addr]};  // Zero-extend
        end else begin
            read_data_o = 32'b0;  // Default for unsupported operations
        end
    end

endmodule

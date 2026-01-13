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
        // Load data for PDF program at offset 0x10000
        $readmemh("data.hex", ram_array, 17'h10000);
    end
    
    // Extract byte address (lower 17 bits)
    logic [ADDR_WIDTH-1:0] byte_addr;
    assign byte_addr = addr_i[ADDR_WIDTH-1:0];
    
    // SYNCHRONOUS WRITE LOGIC
    always_ff @(posedge clk) begin
        if (write_en_i) begin
            case (funct3_i)
                3'b000: begin // SB - Store Byte
                    ram_array[byte_addr] <= write_data_i[7:0];
                end
                3'b001: begin // SH - Store Halfword (little-endian)
                    ram_array[byte_addr]     <= write_data_i[7:0];
                    ram_array[byte_addr + 1] <= write_data_i[15:8];
                end
                3'b010: begin // SW - Store Word (little-endian) - REQUIRED for cache writebacks
                    ram_array[byte_addr]     <= write_data_i[7:0];
                    ram_array[byte_addr + 1] <= write_data_i[15:8];
                    ram_array[byte_addr + 2] <= write_data_i[23:16];
                    ram_array[byte_addr + 3] <= write_data_i[31:24];
                end
                default: begin end
            endcase
        end
    end
    
    
    // ASYNCHRONOUS READ LOGIC  
    always_comb begin
        case (funct3_i)
            3'b000: begin // LB - Load Byte (sign-extended)
                read_data_o = {{24{ram_array[byte_addr][7]}}, ram_array[byte_addr]};
            end
            3'b001: begin // LH - Load Halfword (sign-extended, little-endian)
                read_data_o = {{16{ram_array[byte_addr + 1][7]}}, 
                              ram_array[byte_addr + 1], 
                              ram_array[byte_addr]};
            end
            3'b010: begin // LW - Load Word (little-endian) - REQUIRED for cache refills
                read_data_o = {ram_array[byte_addr + 3], 
                            ram_array[byte_addr + 2],
                            ram_array[byte_addr + 1], 
                            ram_array[byte_addr]};
            end
            3'b100: begin // LBU - Load Byte Unsigned
                read_data_o = {24'b0, ram_array[byte_addr]}; // zero extend
            end
            3'b101: begin // LHU - Load Halfword Unsigned (little-endian)
                read_data_o = {16'b0, 
                              ram_array[byte_addr + 1], 
                              ram_array[byte_addr]};
            end
            default: begin
                read_data_o = 32'b0;
            end
        endcase
    end

endmodule

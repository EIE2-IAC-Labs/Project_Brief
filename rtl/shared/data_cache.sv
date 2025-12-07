//CPU → data_cache → data_mem → CPU
// still needs implementation of cache and stall logic

module data_cache (
    input  logic        clk,
    input  logic        rst,

    input  logic        cpu_req,      // 1 when MEM stage has a valid load/store
    input  logic        cpu_we,       // 1 = store/write, 0 = load/read
    input  logic [31:0] cpu_addr,     // byte address - ALUResultM
    input  logic [31:0] cpu_wdata,    // store data - WriteDataM
    input  logic [2:0]  cpu_funct3,   // funct3M (byte/half/word)
    output logic [31:0] cpu_rdata,    // load result to MEM/WB
    output logic        cpu_stall     // 1 = cache busy (miss, stall pipeline)
);

// Cache configuration (4 KiB, 2-way, 16-byte lines)
    localparam CACHE_BYTES = 4096;
    localparam LINE_BYTES  = 16;
    localparam WAYS        = 2;

    localparam LINE_WORDS  = LINE_BYTES / 4;       // 4 words per line
    localparam NUM_LINES   = CACHE_BYTES / LINE_BYTES;
    localparam NUM_SETS    = NUM_LINES / WAYS;     // 4096 / (16*2) = 128
    localparam INDEX_BITS  = 7;                    // log2(128)
    localparam OFFSET_BITS = 4;                    // log2(16)
    localparam TAG_BITS    = 32 - INDEX_BITS - OFFSET_BITS;

    // Address breakdown
    logic [TAG_BITS-1:0]    addr_tag;
    logic [INDEX_BITS-1:0]  addr_index;
    logic [OFFSET_BITS-1:0] addr_offset;
    logic [1:0]             word_offset;

    assign addr_offset = cpu_addr[OFFSET_BITS-1:0];             // [3:0]
    assign addr_index  = cpu_addr[OFFSET_BITS +: INDEX_BITS];   // [10:4]
    assign addr_tag    = cpu_addr[31           -: TAG_BITS];    // top bits
    assign word_offset = addr_offset[3:2];

// Cache arrays (tags[way][set], valid[way][set], dirty[way][set])
    logic [TAG_BITS-1:0] tag_array   [0:WAYS-1][0:NUM_SETS-1];
    logic                valid_array [0:WAYS-1][0:NUM_SETS-1];
    logic                dirty_array [0:WAYS-1][0:NUM_SETS-1];

    // data[way][set][word]
    logic [31:0]         data_array  [0:WAYS-1][0:NUM_SETS-1][0:LINE_WORDS-1];

    logic                lru_bit     [0:NUM_SETS-1];

    logic miss_load;
    logic [1:0] refill_cnt; // Counts 0..3 during REFILL state
    logic [31:0] mem_rdata; // Output from memory

    // Hit detection:
    logic hit_way0, hit_way1;
    logic hit;
    logic [0:0] hit_way_idx;   // 1 bit since WAYS=2
    logic [31:0] hit_data;
    always_comb begin
        hit_way0 = valid_array[0][addr_index] &&
                   (tag_array[0][addr_index] == addr_tag);
        hit_way1 = valid_array[1][addr_index] &&
                   (tag_array[1][addr_index] == addr_tag);
        hit = hit_way0 | hit_way1;

        // Select which way provided the hit
        // (only for read path)
        hit_way_idx = hit_way1;
        if (hit_way1) hit_data = data_array[1][addr_index][word_offset]; // Way 1 has priority if both hit (should not happen in practice)
        else          hit_data = data_array[0][addr_index][word_offset]; // Way 0 has the hit otherwise
    end



// Cache controller FSM (skeleton - needs to be done)
    typedef enum logic [2:0] {
        C_IDLE, // Checks for cache hits, if miss -> CPU stall, go to C_MISS_SELECT
        C_MISS_SELECT, // Decide which value to evict (LRU based), if dirty -> go to C_WRITEBACK, if clean -> go to C_REFILL
        C_WRITEBACK, // Write back dirty line to memory
        C_REFILL, // Copy new data form main memory into cache
        C_RESPOND // One cycle to stabilize and realize the data is now there.
    } cache_state_t;

    cache_state_t state, next_state;
    logic       victim_way; // Which way are we replacing?
    logic [3:0] shadow_addr; // Captures cpu_addr on miss so that it doesn't change during refill

    // Memory Interface Signals
    // Since memory is instantiated inside, we mux its inputs here
    logic [31:0] mem_addr;
    logic [31:0] mem_wdata;
    logic        mem_we;

    // these decode the "shadow_addr" (the address captured when the miss happened)
    // We use these during REFULL/WRITEBACK because 'cpu_addr' may change while stalled
    logic [INDEX_BITS-1:0]  shadow_index;
    logic [TAG_BITS-1:0]    shadow_tag;
    logic [TAG_BITS-1:0]    victim_tag;

    // These lines extract the index and tag from the shadow address
    assign shadow_index = shadow_addr[OFFSET_BITS +: INDEX_BITS];
    assign shadow_tag   = shadow_addr[31 -: TAG_BITS];
    assign victim_tag   = tag_array[victim_way][shadow_index]; // Retrieve the old tag sitting in the victim slot to build the writeback address

    // State register + reset of cache arrays
    always_ff @(negedge clk or posedge rst) begin
        integer w;
        integer s;
        integer word;

        if (rst) begin
            state <= C_IDLE;
            refill_cnt <= 2'd0;

            // Clear all tags/valid/dirty and data arrays
            for (w = 0; w < WAYS; w++) begin
                for (s = 0; s < NUM_SETS; s++) begin
                    valid_array[w][s] <= 1'b0;
                    dirty_array[w][s] <= 1'b0;
                    tag_array[w][s]   <= '0;

                    for (word = 0; word < LINE_WORDS; word++) begin
                        data_array[w][s][word] <= 32'b0;
                    end
                end
            end

            // Reset LRU bits
            for (s = 0; s < NUM_SETS; s++) begin
                lru_bit[s] <= 1'b0;
            end
        end
        else begin
            state <= next_state;
            // refill_cnt : reset to 0 when we leave IDLE (start of a miss), count 0..3 while in REFILL, reset when leaving REFILL
            case (state)
                C_IDLE: begin
                    refill_cnt <= 2'd0;

                    if (cpu_req && !hit) begin
                        // Start of the logic for a miss
                        shadow_addr <= cpu_addr; // Capture the address that caused the miss
                    end

                    if (cpu_req && hit) begin
                        // On a hit, update the LRU bit
                        lru_bit[addr_index] <= ~hit_way_idx; 

                        if (cpu_we) begin
                            // Write-through on hit, we need to update the cache data and dirty bit!!!
                            data_array[hit_way_idx][addr_index][word_offset] <= cpu_wdata;
                            dirty_array[hit_way_idx][addr_index] <= 1'b1; // Mark as dirty
                        end
                    end
                end

                C_MISS_SELECT: begin
                    // Latch the victim based on the LRU bit of the shadow set
                    victim_way <= lru_bit[shadow_index];
                end

                C_WRITEBACK: begin
                    // Just increment the counter to cycle through words 0..3
                    refill_cnt <= refill_cnt + 2'd1;
                end

                C_REFILL: begin
                    refill_cnt <= refill_cnt + 2'd1;

                    // Write new data from memory into cache
                    data_array[victim_way][shadow_index][refill_cnt] <= mem_rdata;

                    if (refill_cnt == 2'd3) begin // Ont the last word (count 3), update metadata
                        tag_array[victim_way][shadow_index] <= shadow_tag;
                        valid_array[victim_way][shadow_index] <= 1'b1;
                        dirty_array[victim_way][shadow_index] <= 1'b0; // Fresh line is clean!
                    end
                end
            
                default: refill_cnt <= 2'd0;
            endcase
        end
    end

      
    

    assign miss_load = cpu_req && !cpu_we && !hit;  // load + miss

    // Next-state logic for cache controller
    always_comb begin
        next_state = state;
        unique case (state)
            C_IDLE: begin
                if (cpu_req && !hit) // On miss, go select victim
                    next_state = C_MISS_SELECT;
            end

            C_MISS_SELECT: begin
                // Check if the chosen victim (via LRU) is dirty
                if (valid_array[lru_bit[shadow_index]][shadow_index] &&
                    dirty_array[lru_bit[shadow_index]][shadow_index]) begin
                    next_state = C_WRITEBACK; // Need to write back first
                end
                else begin
                    next_state = C_REFILL; // Clean, can go straight to refill
                end
            end

            C_WRITEBACK: begin
                // Write 4 words, then Refill
                if (refill_cnt == 2'd3)  next_state = C_REFILL;
            end
            
            C_REFILL: begin
                // Read 4 words, then Done
                if (refill_cnt == 2'd3)  next_state = C_RESPOND;
            end

            default: next_state = C_IDLE;
        endcase
    end

    // This decides what address/data we send to the slow main memory
    always_comb begin
        mem_we  = 0;
        mem_addr = 0;
        mem_wdata = 0;

        case (state)
            C_WRITEBACK: begin
                // Writing OLD data (Victim) to Memory
                // Addr = {OldTag, SetIndex, WordCount, 00}
                mem_addr = {victim_tag, shadow_index, refill_cnt, 2'b00};
                mem_wdata = data_array[victim_way][shadow_index][refill_cnt];
                mem_we = 1;
            end

            C_REFILL: begin
                // Reading NEW data from Memory
                // Addr = {shadow_tag, shadow_index, WordCount, 00}
                mem_addr = {shadow_tag, shadow_index, refill_cnt, 2'b00};
                mem_we = 0;
            end

            default: begin end
        endcase
    end

    data_mem data_mem_inst (
        .clk          (clk),
        .addr_i       (mem_addr),
        .write_data_i (mem_wdata),
        .write_en_i   (mem_we),
        .funct3_i     (3'b010), // Always Word access for Refills
        .read_data_o  (mem_rdata)
    );


    // Output Assignments 
    always_comb begin
        cpu_stall = 1'b0; // default: no stall
        cpu_rdata = mem_rdata;

        // Stall Logic: If we are not IDLE, or if we are IDLE but missed
        if (state != C_IDLE || (cpu_req && !hit)) begin
            cpu_stall = 1'b1;
        end

        // Data Output Logic
        if (state == C_IDLE && hit) begin
            cpu_rdata = hit_data; // Return cache data
        end 
    end


endmodule

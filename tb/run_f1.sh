#!/bin/bash

# Usage: ./run_f1.sh [single|pipelined]
# Default: single

# Determine CPU type from argument
CPU_TYPE=${1:-single}

if [[ "$CPU_TYPE" != "single" && "$CPU_TYPE" != "pipelined" ]]; then
    echo "Usage: $0 [single|pipelined]"
    echo "  single    - Run with single-cycle CPU (default)"
    echo "  pipelined - Run with pipelined CPU"
    exit 1
fi

# Clean up any previous obj_dir
rm -rf obj_dir/
rm -rf test_out/obj_dir/
rm -rf test_out/6_f1_lights/obj_dir/

# Assemble the code
./assemble.sh asm/6_f1_lights.s

# Create empty data memory file since memory module expects data.hex
touch test_out/6_f1_lights/data.hex

# Copy hex files for verilator
cp test_out/6_f1_lights/program.hex ./program.hex
cp test_out/6_f1_lights/data.hex ./data.hex

# Set top module path based on CPU type
if [[ "$CPU_TYPE" == "pipelined" ]]; then
    TOP_MODULE="../rtl/pipelined/top_pipelined.sv"
    RTL_PATHS="-y ../rtl/pipelined -y ../rtl/shared"
    echo "Using pipelined CPU: $TOP_MODULE"
else
    TOP_MODULE="../rtl/single_cycle/top.sv"
    RTL_PATHS="-y ../rtl/single_cycle -y ../rtl/shared"
    echo "Using single-cycle CPU: $TOP_MODULE"
fi

# Run Verilator with F1 testbench
verilator -Wall -Wno-fatal --trace \
          -cc $TOP_MODULE \
          --exe ./tests/f1_lights_tb.cpp \
          $RTL_PATHS \
          --prefix "Vdut" \
          -o Vdut

# Build C++ project
make -j -C obj_dir/ -f Vdut.mk Vdut

# Run executable
./obj_dir/Vdut

# Move waveform and obj_dir to test directory
mv f1_lights.vcd test_out/6_f1_lights/waveform_${CPU_TYPE}.vcd 2>/dev/null
mv obj_dir test_out/obj_dir_${CPU_TYPE}

# Clean up
rm -f program.hex data.hex

echo "F1 test complete with $CPU_TYPE CPU"
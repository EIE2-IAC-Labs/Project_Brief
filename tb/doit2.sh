#!/bin/bash

# This script runs the testbench for both single-cycle and pipelined CPUs
# Usage: ./doit2.sh [single|pipelined]

# Constants
SCRIPT_DIR=$(dirname "$(realpath "$0")")
TEST_FOLDER=$(realpath "$SCRIPT_DIR/tests")
RTL_FOLDER=$(realpath "$SCRIPT_DIR/../rtl")
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Variables
passes=0
fails=0
cpu_type="single_cycle"  # default

# Handle CPU type argument
if [[ $1 == "single" ]] || [[ $1 == "pipelined" ]]; then
    cpu_type=$1
    shift  # Remove first argument
fi

# Handle test file arguments
if [[ $# -eq 0 ]]; then
    files=(${TEST_FOLDER}/*.cpp)
else
    files=("$@")
fi

cd $SCRIPT_DIR

# Wipe previous test output
rm -rf test_out/*

echo "Testing ${cpu_type} CPU implementation..."

# Set RTL path based on CPU type
if [[ $cpu_type == "pipelined" ]]; then
    TOP_MODULE="${RTL_FOLDER}/pipelined/top_pipelined.sv"
else
    TOP_MODULE="${RTL_FOLDER}/single_cycle/top.sv"
fi

# Iterate through files
for file in "${files[@]}"; do
    name=$(basename "$file" _tb.cpp | cut -f1 -d\-)

    # If verify.cpp -> we are testing the top module
    if [ $name == "verify" ]; then
        name="top"
    fi

    # Translate Verilog -> C++ including testbench
    verilator   -Wall --trace \
                -cc ${TOP_MODULE} \
                --exe ${file} \
                -y ${RTL_FOLDER}/shared \
                -y ${RTL_FOLDER}/pipelined \
                -y ${RTL_FOLDER}/single_cycle \
                --prefix "Vdut" \
                -o Vdut \
                -LDFLAGS "-lgtest -lgtest_main -lpthread"

    # Build C++ project with automatically generated Makefile
    make -j -C obj_dir/ -f Vdut.mk

    # Run executable simulation file
    ./obj_dir/Vdut

    # Check if the test succeeded or not
    if [ $? -eq 0 ]; then
        ((passes++))
    else
        ((fails++))
    fi
done

# Save obj_dir in test_out with CPU type suffix
mv obj_dir test_out/obj_dir_${cpu_type}

echo "CPU Type: ${cpu_type}"
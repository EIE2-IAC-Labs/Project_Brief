<center>

## EIE2 Instruction Set Architecture & Compiler (IAC)

---
## Verification of the CPU

**Ryan Voecks, V2.0 - 25 Nov 2024**

---

</center>

## Quick Start

The verification testing in this repository is significantly different from Lab 4. You will need to copy the new `tb` folder to your coursework repository.

To run the tests, run the `doit.sh` script in this folder.

**IMPORTANT - Your code must meet the following requirements for the script to work properly:**
1. Your RTL must be in a top-level folder called `rtl`.
2. The top-level module of your RTL must have the following interface:
```sv
module top (
    input logic clk,
    input logic rst,
    input logic trigger,
    output logic [31:0] a0
);

endmodule
```
3. Your instruction memory must load the file `"program.hex"`.
4. Your data memory must load the file `"data.hex"`.

To keep the RTL consistent, it is recommended to use a shell script that moves the correct hex instructions and data into `"program.hex"` and `"data.hex"` when testing the PDF and F1 starting lights for Vbuddy.

## Explanation of the tests

The `doit.sh` script compiles a verilator model of your RTL, using the `src/verify.cpp` testbench. The following steps are then taken for each test program:
1. Assemble the program.
2. Load the program (and data if needed) into the CPU memory.
3. Run the verilator model for many cycles.
4. Check if the return value (a0) matches the expected value.

The verilator-generated `obj_dir` is stored in `tb/test_out`, along with the waveform, hex and disassembly for each test.

You are free to add more tests if it helps with your testing, but you are only required to pass the tests given in this repository (alongside PDF and F1 programs on Vbuddy).

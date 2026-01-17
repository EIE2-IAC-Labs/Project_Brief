# Personal Statement - Deniz Yilmazkaya

## Contents
- [Overview](#overview)
- [Key Technical Contributions](#key-technical-contributions)
	- [1. Single Cycle CPU Testing and Top-Level Design](#1-single-cycle-cpu-testing-and-top-level-design)
	- [2. Verification](#2-verification)
   		- [2.1 F1 Starting Lights Implementation and Testing](#21-f1-starting-lights-implementation-and-testing)
    	- [2.2 Reference Program](#22-reference-program)
	  	- [2.3 Full RV32I Design Testing](#23-full-rv32i-design-testing)
	- [3. Pipelining Integration and Testing](#3-pipelining-integration-and-testing)
	- [4. Cache Memory Integration and Testing](#4-cache-memory-integration-and-testing)
- [Key Design Decisions](#key-design-decisions)
- [Reflection](#reflection)
---
## Overview
Working as the verification and integration engineer for the team, my role was to unify the individual building blocks of the RISC-V CPU and conduct tests checking the integrity of the processor, and debug the lower level modules when necessary. 

Outside of the automated testing, I used GTKWave and Vbuddy for visual verification of the processor, notably for the F1-Lights and PDF implementations that used C++ testbenches and shell scripts for easier testing.

I found this role to be very engaging as I had to have a strong sense of all the modules during testing and debugging, allowing me to work in collaboration with my teammates at times. Furthermore, seeing the processor working after constant hours of work was very rewarding.

---  
## Key Technical Contributions:  

### 1. Single Cycle CPU Testing and Top Level Design

For the single cycle implementation, I initially created the `top.sv` module that connected all the lower level components. At the beginning of the project, since we were doing the reduced RISC-V implementation, the PC logic on the top module involved incrementing to PC+4 and the BNE instruction. Later, for the full RISC-V32I implementation I had to change both the **ALUControl** signal from 3, to 4 bits to make up for the new instructions and add further logic for the other branch instructions (BEQ, BLT, BGE, BLTU, BGEU) which involved adapting the `control_unit.sv` and `top.sv`. (Commit: 889aa36)

Moreover, on the initial implementation of the single-cycle processor, apart from small, quick fixes regarding **a0** register connection, there were problems in the instruction memory module causing instructions to not actually be fetched during testing, making the output of every test equal to 0. This was fixed in collaboration with my teammate, Lila. (Commit: 21f8a12)

---
### 2. Verification
#### 2.1 F1 Starting Lights Implementation and Testing

The testbench for the F1 lights was very similar to the one from Lab-3 (Commit: 611f91f), however, my teammate Lila and I ran into a problem whilst testing; the lights were turning on as they were supposed to, however, the first LED was blinking, so for debugging I added this to the testbench to monitor the value of register **a0**: 

``` cpp
        // Display F1 light pattern
        vbdBar(top->a0 & 0xFF);
        
        // Also display on hex for debugging
        vbdHex(4, (top->a0 >> 4) & 0xF);
        vbdHex(3, top->a0 & 0xF);
```
This enabled us to notice that the assembly code was not incrementing with the pattern 2n+1 as it was supposed to since it was being done in two operations. Therefore, we added a temporary register that would then be used to change the value of a0 (Commit: febede2):
``` asm
increment_light:
    ADD  t3, a0, a0         # t3 = a0 * 2 (use temp register)
    ADDI t3, t3, 1          # t3 = t3 + 1
    ADD  a0, t3, zero       # a0 = t3 (instant update)
    JALR zero, ra, 0        # Return
```

Afterwards, when the remaining RISC-V32I instructions were added, I modified the assembly code to include a random delay using the principles of the LFSR circuit we learned during Lab-3, here is a snippet of that code: 
``` asm
# Subroutine: Update 4-bit LFSR
# Implements primitive polynomial x^4 + x^3 + 1
# LFSR state stored in s1
lfsr_update:
    # Get bit 3
    SRLI t3, s1, 3          # Shift right by 3 positions
    ANDI t3, t3, 0x01       # Mask to get only bit 3
    
    # Get bit 2
    SRLI t4, s1, 2          # Shift right by 2 positions
    ANDI t4, t4, 0x01       # Mask to get only bit 2
    
    # XOR the two taps to get feedback bit
    XOR  t3, t3, t4         # t3 = bit[3] XOR bit[2]
    
    # Shift LFSR left by 1 position
    SLLI s1, s1, 1          # Shift left
    
    # Insert feedback bit at LSB
    OR   s1, s1, t3         # Insert feedback bit
```
(See Commit: 3fc193c for further details.)


#### 2.2 Reference Program
Whilst writing shell scripts for running F1 and PDF, I wanted to make the structure of them similar to `doit.sh` because I liked how tidy it kept the output files from the testing results. 

Additionally, instead of changing the name of the distribution on the testbench file each time, I found that it was more elegant to write the shell script so that it took the distribution name as a target as well. (Commit: 1ab5358) For example, to run **noisy.mem** you would type
``` bash
./run_pdf.sh reference/noisy.mem
```
Another decision I made was to add an optional delay for the plotting on the testbench since it was being displayed too quick on the Vbuddy screen, making it difficult to observe the behavior of the PDF and confirm that it was working. 

Pictures of the plots:

![PDF](../tb/test_images/PDF_Gaussian_Photo.png)
![PDF](../tb/test_images/PDF_Noisy_Photo.png)
![PDF](../tb/test_images/PDF_Triangle_Photo.png)


#### 2.3 Full RV32I Design Testing
In order to test the full RISC-V32I implementation I wrote six further assembly tests, checking whether the individual instructions work, considering the edge cases for instructions such as branches and shifts. These can be viewed under the `tb/asm` folder. (See Commit: ee95a97 for the assembly test files.) 

After adding these tests, I modified `verify.cpp` so that they were included in the automatic testing. 

<p align="center">
  <img src="../tb/test_images/FullRISCV_SingleCycle.png" width="600">
</p>

---
### 3. Pipelining Integration and Testing

In order to test the pipelined implementation, I created a new script `doit2.sh`, almost identical to the original `doit.sh`, the main difference being that you can choose between running automated tests on the single-cycle and the pipelined CPU, i.e. 
```bash
./doit2.sh # for single-cycle
./doit2.sh pipelined # for pipelined
```
This made it easier to see if a bug during the implementation of new additions to the processor were due to mistakes under the `rtl/shared` folder between single-cycle and pipelined, or their own respective programs. 

The initial pipelined implementation proved to require debugging; one of the main issues being that the pipeline registers were being written on the positive edge of the clock whereas it should have been the negative. This way, data could be written in the first half cycle and read back in the second. (Commit: 7e0534b) Furthermore, there were bug fixes regarding the forwarding logic on the pipeline. (Commit: 8a75343)

### 4. Cache Memory Integration and Testing

To effectively test the cache memory, I added further assembly tests, namely `8_cache_hit.s`, and `9_cache_miss_set_conflict.s` which verified that repeated loads from the same address caused a hit in the cache, and the 2-way set behavior was also working in cases where there were conflicting memory addresses. For the cache implementation to pass the tests, I had to add proper stall signal propagation to pipeline registers and cache stall logic for the hazard unit. Additionally, with Lila we changed the timing of the cache FSM to match memory timing and did further handling for misses using further implementation of shadow registers. (Commit: 37f8839)

Example from `8_cache_hit.s` test: 

![CacheMem](../tb/test_images/CacheMemoryWaveform.png)
*Shows cache state machine progressing correctly.*

Initially CPU stalls during cache miss as expected, and begins the refill process. Cache hit_way0 goes high whilst hit_way1 stays low showing correct behavior for the data access. After the process cpu_rdata[31:0] has the correct value of 0x0000002A.

---
### Key Design Decisions
- Modifying the shell scripts so that they support both the pipelined and the single-cycle CPU made it seamless to switch between the implementations, making it substantially easier to find bugs. 
- Started with a simple F1 script without random delay at the end and modified the original to have random delay after the other instructions were implemented.
- Standardized all the test scripts (`run_f1.sh`, `doit2.sh` etc.) to be structured the same way as the original `doit.sh` script for consistent file handling under the `tb/test_out` folder, making the repository cleaner. 

### Reflection
Throughout the project, our team was very efficient at systematically building the lower level modules for each implementation. However, debugging the processor proved to be a task that required a great amount of patience and perseverance, and something that I should not have done by myself at times. I noticed that when I worked in collaboration with my teammates, having multiple perspectives on a situation helped debug the system quicker. 

A painful example of this was when the tests were running on my teammate, Lila's laptop, but not on mine. Proper communication allowed me to realize that this issue was due to my compiler being outdated compared to others - something that would have taken me many further hours to notice. 

For the testing aspect, creating a script that would build files with randomly generated RISC-V instructions would ensure that the processor was working for all edge cases. Unfortunately, I did not have time to implement this. Yet, I believe that the implemented instructions are still being tested effectively through visual and automated verification. 

Overall, this project gave me valuable experience in hardware design and testing whilst working as a team, giving a sense of how a future career in hardware engineering would be. Even though at times debugging proved to be difficult, it was very rewarding to see a final working product that has passed all the testing.  

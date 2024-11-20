<center>

## EIE2 Instruction Set Architecture & Compiler (IAC)

---
## Team Project - RISC-V RV32I Processor

**_Peter Cheung, V1.5 - 20 Nov 2024_**

---

</center>

## Objectives

* To learn RISC-V 32-bit integer instruction set architecture 
* To implement a single-cycle RV32I instruction set in a microarchitecture
* To implement the F1 starting light algorithm in RV32I assembly language
* To verify your RV32I design
* As stretched goal, to implement a simple pipelined version of the microarchitecture with hazard detection and mitigation
* As a further stretched goal, add data cache to the pipelined RV32I
* As a further streched goal, complete the RV32I processor

<br>

___

## Learning the RV32I Instruction Set
___

Before you start the hardware design, every team member should learn the RV32I in some detail by jointly creating your team's assembly language program to implement the F1 starting light algorithm from Lab 3 in RV32I instructions.

[This document](https://cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf) contains the instructions to be tested. You do not need to implement the `ecall` and the `ebreak` instructions. Note that the **Jump and Link (JAL)** instruction must be implemented. Your team's F1 program, together with [integration tests](verification.md) will be used to test your processor implementation.

<p align="center"> <img src="images/RISC-V_F1.jpg" /> </p><BR>

Unlike Lab 3, the clock signal does not control a hardware counter or state machine directly. Instead it is used to clock the RISC-V processor to execute one instruction.  The Reset signal also resets only the processor to start the program, and is not used to reset counters or a state machine.  The trigger signal is used to tell RISC-V when to start the F1 light sequence.  How it is implemented in the RISC-V is not defined.  You can decide, for example, that the trigger is automatic -- as soon as the program starts, the F1 light sequence is triggered.  

You should also write your assembly language program using the following memory map. 

<p align="center"> <img src="images/memory.jpg" /> </p><BR>

This memory map is chosen to help debugging your design later.  What is the size of the data and instruction memory specified by this map?  Remember, both instructions and data are 32-bits or 4 bytes.  RISC-V is a byte-addressing processor with least significant byte in lower address. This is called "little-endian".

<br>

___

## Single-Cycle RV32I Design
___

>This is the basic goal for every team - to implement the basic RV32I instruction set by extending your Reduced RISC-V design in Lab 4. 

To simplify matters, you should assume that you have separate instruction and data memories.

Similar to Lab 4, you must divide the task into roughly equal components, and each student will then be responsbile for one component.  You can continue your role as in Lab 4 or, to diversify your learning, deliberately assigning a different component to your team members. The assessment of this project coursework will be mostly based on individual contributions with a smaller component based on the team's success.  Details on assessment and deliverable are provided later in this project brief.

Your processor must pass a reasonable amount of tests provided in the repo, as well as work for your team's F1 starting light program. All tests are provided in this repo. See [verification.md](verification.md#quick-start) for more information.

>[!NOTE] 
> You do NOT have to pass all the provided test cases. Move on when you
have passed 15-20 tests. Note that debugging at this stage is easier.

<br>

<p align="center"> <img src="images/single-cycle.jpg" /> </p><BR>

<br>

___
## Stretch Goal 1: Pipelined RV32I Design
___

>Once finished the basic goal, if your team have time, modify the the single-cycle processor to a pipelined processor.  

A simple solution is to handle data and control hazards in software - by identifying and inserting NOPs, or by re-ordering instructions to avoid hazards.  

For full credit, you are expected in implement hardware hazard detection, forwarding/bypassing or stalling hardware.

As before, make sure that your design is working by successfully running the tests.

<br>

___
## Stretch Goal 2: Adding Data Memory Cache
___

As an additional stretch goal to the pipelined processor, you may also add data cache to your data memory. This is of course a "toy" exercise because your data memory is already a single-cycle memory and is very fast. Adding cache memory may make this slower, not faster.  However, in real designs, data memory could be quite slow. Then, adding cache memory will help performance.  Nevertheless, you may learn how cache memory works by implement it as an addition to your pipelined processor.

The data cache capacity should be no more than 1024 bytes.  You may choose to implement a direct-mapped or associative cache.

<br>

___
## Stretch Goal 3: Full RV32I Design
___
> You may decide that it is easier to do this before or whilst creating a pipelined processor.

If you really have time, then complete the full RISC-V ISA. This means that all of the provided tests pass.

___

## Deliverables
___

All deliverables must be via your Team's project coursework repo via the GitHub link you have provided for your team. The name of the repo has your team number at the end, and is private to your team, but accessible by myself.  All deliverables **must be** in the repo by *__mid-night Friday 15 December 2023__* when all coursework team repos must be frozen.  

Deliverables must include the following:
1. A **brief** `README.md` file in the root directory that describes what your team has achieved. This is a **joint statement** for the team. 
2. Each individual's **personal statement** explaining what you contributed, a reflection about what you have learned in this project, mistakes you made, special design decisons, and what you might do differently if you were to do it again or have more time.  This statement must be succinct and to the point, yet must include sufficient details for me to check against the commit history of the repo so that any claims can be verified. Including links to a selection of specific commits which demonstrate your work would be most helpful. If you work with another member of your group on a module, make sure to give them [co-author credit](https://docs.github.com/en/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/creating-a-commit-with-multiple-authors#creating-co-authored-commits-on-the-command-line). Additionally, try to make meaningful commit messages.
3. A folder called `rtl` with the source of your processor. If you have multiple versions due to the stretched goals, you may use branches/[tags](https://git-scm.com/book/en/v2/Git-Basics-Tagging). Your `README.md` file must provide sufficient explanation for me to understand what you have done and how to find your work on all branches/tags you wish to be assessed.  The `rtl` folder should also include a `README.md` file listing who wrote which module/file.
4. A `tb` folder with your F1 program. The folder must also contain test results for your processor successfully executing the F1 program. 

You must also provide a Makefile or a shell script that allows me to build your processor model and run the tests provided in this repo. You must also provide an option to run your F1 program.

<br>

___

## Assessment Criteria
___

Assessment for this coursework, which accounts for 25% of the entire two-terms IAC module, is divided into two components:
1. Team achievement (40%) - This component of the marks is common to all team members and is dependent on the overall achievement of the team.
2. Individual achievement (60%) - This component of the marks is awarded to individual student based on declaration by the team of the individual contribution, with verification based on evidence (e.g. based on the git commit and push profile of an individual), individual account of his/her contributions and reflections, and the actual deliverables by the individual in terms of SystemVerilog, C++ codes and/or test results.

This table shows the level of team's achievement and the range of grade to be awarded.

<p align="center"> <img src="images/team_grade.jpg"> 

Here are the criteria on which individual assessment will be based.

<p align="center"> <img src="images/individual.jpg"> 

<br>

---
## Tips
---

* Agree a coding style between your team and stick to it. [This document](https://github.com/lowRISC/style-guides/blob/master/VerilogCodingStyle.md) contains many suggested practices which are good to follow.
* Suffix module inputs and outputs with `_i` or `_o` respectively. This will make it much easier to understand what you are looking at in Gtkwave.
* Setup a `.gitignore` file to prevent yourself from committing generated files, the `obj_dir` directory and `vcd` files into Git
* Review each file before you stage and commit it into Git. You will catch many errors this way. VS Code has [in-built tooling]( https://code.visualstudio.com/docs/sourcecontrol/overview) for Git which you should try to get familiar with.
* Write [useful commit messages](https://cbea.ms/git-commit/)
* Work on your own branches on Git and get other members of your team to review your code before merging it in to the main branch

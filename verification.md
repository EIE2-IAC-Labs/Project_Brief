<center>

## EIE2 Instruction Set Architecture & Compiler (IAC)

---
## Verification of the CPU

**@saturn691, V1.0 - 14 Nov 2024**

---

</center>

## Quick Start

If you are using the model repo provided in Lab4, copy all the tests from the [`c`](c) folder to the `c` folder in your repo. Otherwise, place the files wherever it needs to be.

```sh
rm -rf <your-repo/tb/c>
rm <your-repo/tb/tests/verify.cpp>
cp -r tb/c <your-repo/tb>
cp tb/tests/verify.cpp <your-repo/tb/tests>
```

Then run the `doit.sh` script as usual, provided in the Lab4 repo.

## Explanation of the tests

This section is for reference and can be skipped at your discretion. It will explain the C tests.

The tests are treated as follows:
1. It is compiled
2. It is ran on your CPU for a reasonable amount of clock cycles.
3. The result (a0) is checked against the expected result of the program

You can check the expected result of the program by running the tests locally.

```sh
clang c/01-add.c
./a.out

# If you don't see anything- check the return code
echo $?
```

The tests have been tested on my CPU implementation and all of them pass on my CPU.


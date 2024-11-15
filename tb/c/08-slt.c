#if !defined(__riscv)
#include <stdio.h>
#else

// entry point (0x0): compiler places earlier functions lower in memory.
int main();

void _start()
{
    main();

    // Infinite loop to prevent undefined access to memory
    while (1)
    {
    }
}

#endif

int main()
{
    int num1 = 10;
    int num2 = -24;

    // slt (set less than)
    int slt_result = (num1 < num2) ? 1 : 0;

    // slti (set less than immediate)
    int slti_result = (num2 < 10) ? 1 : 0;

    // Concatenate the bits
    int ans = (slt_result << 1) + slti_result;

#if !defined(__riscv)
    printf("slt: %d\n", slt_result);
    printf("slti: %d\n", slti_result);
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 1
    return ans;
}
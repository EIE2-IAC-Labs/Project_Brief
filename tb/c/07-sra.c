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
    // Negative number
    int num = -9999;
    int shift_amount = 5;

    // sra (arithmetic right shift)
    int sra_result = num >> shift_amount;

    // srai (arithmetic right shift immediate)
    int ans = num >> 3; // Shift by a constant amount

#if !defined(__riscv)
    printf("sra: %d\n", sra_result);
    printf("ans: %d\n", (int)ans);
#endif

    // EXPECTED OUTPUT = -1250
    return ans;
}
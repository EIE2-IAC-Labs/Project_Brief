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
    unsigned int num = 0x123213;
    int shift_amount = 5;

    // srl (logical right shift)
    unsigned int srl_result = num >> shift_amount;

    // srli (logical right shift immediate)
    unsigned int ans = srl_result >> 3; // Shift by a constant amount

#if !defined(__riscv)
    printf("srl: %d\n", srl_result);
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 4658
    return ans;
}
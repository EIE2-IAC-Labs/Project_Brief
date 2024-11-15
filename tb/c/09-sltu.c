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

    // sltu (set less than unsigned)
    unsigned int sltu_result = ((unsigned int)num1 < (unsigned int)num2) ? 1 : 0;

    // sltiu (set less than immediate unsigned)
    unsigned int sltiu_result = ((unsigned int)num2 < 30) ? 1 : 0;

    // Concatenate the bits
    int ans = (sltu_result << 1) + sltiu_result;

#if !defined(__riscv)
    printf("sltu: %d\n", sltu_result);
    printf("sltiu: %d\n", sltiu_result);
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 2
    return ans;
}
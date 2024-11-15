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
    int num1 = 1234;
    int num2 = 4321;
    int num3 = 2345;

    int temp1 = num1 | num2 | num3;
    int ans = temp1 | 540; // ori instruction

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 8191
    return ans;
}
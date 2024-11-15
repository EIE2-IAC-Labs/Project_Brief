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
    int var = 0x4369;

#if !defined(__riscv)
    printf("%d\n", var);
#endif

    // EXPECTED OUTPUT = 17257
    return var;
}
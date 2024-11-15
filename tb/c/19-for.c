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
    int ans = 0;

    for (int i = 0; i <= 100; ++i)
    {
        ans += i;
    }

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 5050
    return ans;
}
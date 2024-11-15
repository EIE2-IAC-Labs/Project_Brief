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

    unsigned char byteArray[5] = {0x11, 0x22, 0x33, 0x44, 0x55};

    // Take the sum
    for (int i = 0; i < 5; ++i)
    {
        ans += byteArray[i];
    }

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 255
    return ans;
}
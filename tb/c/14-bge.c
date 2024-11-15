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
    int ans = 111;

    // Test bge
    while (ans < 300)
    {
        ans++;
    }

#if !defined(__riscv)
    // Print the array elements
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 300
    return ans;
}
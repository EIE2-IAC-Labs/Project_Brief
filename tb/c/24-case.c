/**
 * HINT: Compile this program with:
 * -fno-jump-tables
 */

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
    int ans;
    int x = 5;

    switch (x)
    {
    case 1:
        ans = 1;
        break;
    case 2:
        ans = 2;
        break;
    case 3:
        ans = 3;
        break;
    case 4:
        ans = 4;
        break;
    case 5:
        ans = 5;
        break;
    default:
        ans = 0;
        break;
    }

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 5
    return ans;
}
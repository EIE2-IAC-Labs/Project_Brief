.text
.globl main
# Testing bitwise operations
main:
    li t0, 12              # 0b1100
    li t1, 10              # 0b1010
    
    # XOR test
    xor t2, t0, t1         # t2 = 6 (0b0110)
    
    # OR test
    or t3, t0, t1          # t3 = 14 (0b1110)
    
    # AND test
    and t4, t0, t1         # t4 = 8 (0b1000)
    
    # Add results: 6 + 14 + 8 = 28
    add a0, t2, t3
    add a0, a0, t4
    
    # a0 should be 28
    
finish:
    bne a0, zero, finish

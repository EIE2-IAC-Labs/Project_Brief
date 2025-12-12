.text
.globl main
# Test comparison edge cases
main:
    li a0, 0
    
    # comparing simple numbers
    li t0, 5
    li t1, 10
    slt t2, t0, t1         # 5 < 10 = true (1)
    add a0, a0, t2         # a0 = 1
    
    # equal numbers
    li t3, 10
    li t4, 10
    slt t5, t3, t4         # 10 < 10 = false (0)
    add a0, a0, t5         # a0 = 1 + 0 = 1
    
    # greater than
    li t6, 20
    li s0, 10
    slt s1, t6, s0         # 20 < 10 = false (0)
    add a0, a0, s1         # a0 = 1 + 0 = 1
    
    # immediate compare
    slti s2, t0, 10        # 5 < 10 = true (1)
    add a0, a0, s2         # a0 = 1 + 1 = 2
    
    # expected a0: 2
    
finish:
    bne a0, zero, finish

.text
.globl main
# Test all the shift operations
main:
    li t0, 16        
    
    # Test shift left logical
    slli t1, t0, 2         # t1 = 64 (16 << 2)
    
    # Test shift right logical  
    li t2, 64
    srli t3, t2, 2         # t3 = 16 (64 >> 2)
    
    # Test shift right arithmetic (sign extend)
    li t4, -32             # negative number
    srai t5, t4, 2         # t5 = -8
    
    # Test with registers
    li t6, 3
    sll a0, t0, t6         # a0 = 128 (16 << 3)
    add a0, a0, t5         # a0 = 120
    add a0, a0, t1         # a0 = 184
    add a0, a0, t3         # a0 = 200
    
    # expected a0: 200
    
finish:
    bne a0, zero, finish

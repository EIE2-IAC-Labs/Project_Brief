.text
.globl main
# Test when both operands are equal
main:
    li a0, 0
    li t0, 10
    li t1, 10              # both are equal
    
    # BEQ with equal values - MUST take
    beq t0, t1, eq1
    addi a0, a0, 100
    j t2_test
eq1:
    addi a0, a0, 1         # if branch doesnt work goes into here and increments a0
    
t2_test:
    # BNE with equal values - MUST NOT take
    bne t0, t1, neq1
    addi a0, a0, 1
    j t3_test
neq1:
    addi a0, a0, 100       # if branch doesnt work goes into here and increments a0
    
t3_test:
    # BLT with equal values - MUST NOT take (10 not < 10)
    blt t0, t1, lt1
    addi a0, a0, 1
    j t4_test
lt1:
    addi a0, a0, 100       # if branch doesnt work goes into here and increments a0
    
t4_test:
    # BGE with equal values - MUST take (10 >= 10)
    bge t0, t1, ge1
    addi a0, a0, 100
    j t5_test
ge1:
    addi a0, a0, 1         # if branch doesnt work goes into here and increments a0
    
t5_test:
    # BLTU with equal values - MUST NOT take
    bltu t0, t1, ltu1
    addi a0, a0, 1
    j t6_test
ltu1:
    addi a0, a0, 100       # if branch doesnt work goes into here and increments a0
    
t6_test:
    # BGEU with equal values - MUST take
    bgeu t0, t1, geu1
    addi a0, a0, 100
    j done
geu1:
    addi a0, a0, 1         # if branch doesnt work goes into here and increments a0

done:
    # a0 should be 6 if all branches work correctly
    
finish:
    bne a0, zero, finish

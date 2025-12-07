.text
.globl main

main:
    lui     a0, 0
    addi    a0, a0, 0       # a0 = 0 (current LED pattern display)
    lui     t3, 0
    addi    t3, t3, 0xFF    # t3 = 0xFF (all lights on marker)

light_loop:
    # Faster delay
    lui     t1, 0x0
    addi    t1, t1, 5       # t1 = 5
delay_loop:
    addi    t1, t1, -1      # Decrement
    bne     t1, zero, delay_loop
    
    # Instant increment using temporary register
    add     t2, a0, a0      # t2 = a0 * 2 (shift left)
    addi    t2, t2, 1       # t2 = t2 + 1
    add     a0, t2, zero    # a0 = t2 (instant update!)
    
    # Check if all lights on
    bne     a0, t3, light_loop
    
all_on:
    # Delay with all lights on
    lui     t1, 0x0
    addi    t1, t1, 5
delay_all_on:
    addi    t1, t1, -1
    bne     t1, zero, delay_all_on
    
    # Turn all lights off
    lui     a0, 0
    addi    a0, a0, 0       # a0 = 0
    
    # Delay with lights off
    lui     t1, 0x0
    addi    t1, t1, 5
delay_off:
    addi    t1, t1, -1
    bne     t1, zero, delay_off
    
    # Restart sequence
    jal     zero, main
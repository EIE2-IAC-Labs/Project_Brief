.text
.globl main
# Store and load at different byte offsets
main:
    li s0, 0x00010000
    
    # store bytes at different offsets
    li t0, 10
    sb t0, 0(s0)
    li t1, 20
    sb t1, 1(s0)
    li t2, 30
    sb t2, 2(s0)
    li t3, 40
    sb t3, 3(s0)
    
    # load individual bytes back
    lbu t4, 0(s0)          # should be 10
    lbu t5, 1(s0)          # should be 20
    lbu t6, 2(s0)          # should be 30
    lbu a1, 3(s0)          # should be 40
    
    # add them all: 10 + 20 + 30 + 40 = 100 (expected a0)
    add a0, t4, t5
    add a0, a0, t6
    add a0, a0, a1
    
finish:
    bne a0, zero, finish

.text
.globl main
# Test storing halfwords and words
main:
    li s0, 0x00010000
    
    # store halfwords
    li t1, 100
    sh t1, 0(s0)
    
    li t2, 200
    sh t2, 2(s0)
    
    # load them back
    lhu t4, 0(s0)          # should be 100
    lhu t5, 2(s0)          # should be 200
    
    # add the halfwords: 100 + 200 = 300
    add a0, t4, t5
    
    # expected a0: 300
    
finish:
    bne a0, zero, finish

# Test that repeated loads from same address hit in cache
.text
.globl main
main:
    li s0, 0x00010000
    li t0, 42
    sb t0, 0(s0)        # Store 42
    
    # These should all hit in cache
    lbu a0, 0(s0)       # Load 1
    lbu a1, 0(s0)       # Load 2 (cache hit)
    lbu a2, 0(s0)       # Load 3 (cache hit)
    
    add a0, a0, a1
    add a0, a0, a2      # Expected: 126 (42*3)
    
finish:
    bne a0, zero, finish

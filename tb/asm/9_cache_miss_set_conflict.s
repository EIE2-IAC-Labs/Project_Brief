# Access addresses that map to same cache set
# Cache implementation: 128 sets, 16-byte lines
# Addresses 0x10000, 0x10800, 0x11000 all map to set 0
.text
.globl main
main:
    li s0, 0x00010000
    li s1, 0x00010800   # Different set due to index bits
    
    li t0, 100
    sb t0, 0(s0)        # Miss, load line into way 0
    
    li t1, 200
    sb t1, 0(s1)        # Miss, load line into way 1
    
    lbu a0, 0(s0)       # Should hit (way 0)
    lbu a1, 0(s1)       # Should hit (way 1)
    
    add a0, a0, a1      # Expected: 300
    
finish:
    bne a0, zero, finish

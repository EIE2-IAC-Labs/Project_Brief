.text
.globl main
main:
    # li is broken into lui and addi for >12-bit values
    # don't forget that addi sign-extends
    li t1, -9000    # t1 = -9000
    li t2, 10000    # t2 = 10000
    add a0, t1, t2  # a0 = t1 + t2      (=1000)
    bne     a0, zero, finish    # enter finish state

finish:     # expected result is 1000
    bne     a0, zero, finish     # loop forever

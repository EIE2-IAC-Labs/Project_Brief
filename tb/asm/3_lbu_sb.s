.text
.globl main
main:
    li s0, 0x00010000   # create pointer to base of data array

    li t1, 100
    sb t1, 0(s0)    # store 100 at address 0x00010000
    li t2, 200
    sb t2, 1(s0)    # store 200 at address 0x00010001

    lbu t3, 0(s0)   # t3 = *(0x00010000)    (=100)
    lbu t4, 1(s0)   # t4 = *(0x00010001)    (=200)
    add a0, t3, t4  # a0 = t3 + t4          (=300)
    bne     a0, zero, finish    # enter finish state

finish:     # expected result is 300
    bne     a0, zero, finish     # loop forever

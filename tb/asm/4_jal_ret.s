.text
.globl main
main:
    li t1, 50           # t1 = 50
    jal ra, add_one     # call add_one (t1 = 51)
    jal ra, add_one     # call add_one (t1 = 52)
    jal ra, add_one     # call add_one (t1 = 53)
    j finish
add_one:
    addi t1, t1, 1      # t += 1
    ret                 # return to main

finish:     # function to set the return value then wait
    addi    a0, t1, 0           # a0 = t1 (expected = 53)
_wait:
    bne     a0, zero, _wait     # loop forever

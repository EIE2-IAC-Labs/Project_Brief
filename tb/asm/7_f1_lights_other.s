# F1 Starting Lights - Basic Test Version 
# Matches Lab 3 FSM behavior: progressively turn on lights
# Pattern: 0x00 -> 0x01 -> 0x03 -> 0x07 -> 0x0F -> ... -> 0xFF

.text
.equ LIGHT_ADDR, 0x100

main:
    LI   s0, LIGHT_ADDR     # Light output address
    LI   a0, 0              # Start with no lights
    
light_on_loop:
    SB   a0, 0(s0)          # Store current pattern
    
    # Add delay
    JAL  ra, delay
    
    # Check if all lights on before incrementing
    LI   t0, 0xFF           # Check if all lights on (0xFF = 0b11111111)
    BNE  a0, t0, not_all_on
    
    # All lights on - turn them off and restart
    LI   a0, 0              # Turn off lights
    SB   a0, 0(s0)          # Write 0 to lights
    JAL  ra, delay          # Delay with lights off
    
    # Restart from beginning
    J    main
    
not_all_on:
    JAL  ra, increment_light # Call subroutine to get next pattern
    J    light_on_loop

# Subroutine: Increment light pattern using temp register
# Creates sequence: 0 -> 1 -> 3 -> 7 -> 15 -> 31 -> 63 -> 127 -> 255
# Formula: new = (old * 2) + 1

increment_light:
    ADD  t3, a0, a0         # t3 = a0 * 2 (use temp register)
    ADDI t3, t3, 1          # t3 = t3 + 1
    ADD  a0, t3, zero       # a0 = t3 (instant update)
    JALR zero, ra, 0        # Return

# Subroutine: Delay
delay:
    LI   t1, 2              # Delay counter (adjust to change the delay)
delay_loop:
    ADDI t1, t1, -1         # Decrement
    BNE  t1, zero, delay_loop
    JALR zero, ra, 0        # Return
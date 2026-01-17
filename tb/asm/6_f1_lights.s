# F1 Starting Lights - Random Delay Using LFSR
# Pattern: 2n+1 until reaches 0xFF and then add random delay when all the lights turn off

.text

main:
    LI   s1, 0x0F           # Initialize LFSR (non-zero seed)
    LI   a0, 0              # Start with no lights
    
light_on_loop:

    # Add delay between light transitions
    JAL  ra, delay
    
    # Check if all lights on before incrementing
    LI   t0, 0xFF
    BNE  a0, t0, not_all_on
    
    # All lights on - update LFSR and do random delay
    JAL  ra, lfsr_update
    
    # Use LFSR value directly as delay counter (1-15 cycles)
    ANDI t1, s1, 0x0F       # Use all 4 bits (0-15)
    ADDI t1, t1, 1          # Make it 1-16 to ensure non-zero

random_delay_loop:
    ADDI t1, t1, -1         # Decrement
    BNE  t1, zero, random_delay_loop
    
    # Turn off all lights
    LI   a0, 0
    JAL  ra, delay          # Delay with lights off
    
    # Restart from beginning
    J    main
    
not_all_on:
    JAL  ra, increment_light    # Call subroutine to get next LED
    J    light_on_loop

# Subroutine: Increment light pattern
# Creates sequence of 2n+1
# Formula: new = (old << 1) + 1
# Use temporary register t3 for immediate change in a0 instead of blinking
increment_light:
    SLLI t3, a0, 1          # t3 = a0 << 1 (multiply by 2)
    ADDI a0, t3, 1          # a0 = t3 + 1
    JALR zero, ra, 0        # Return

# Subroutine: Standard delay
delay:
    LI   t1, 2              # Delay counter (adjust to change the delay)
delay_loop:
    ADDI t1, t1, -1         # Decrement
    BNE  t1, zero, delay_loop
    JALR zero, ra, 0        # Return

# Subroutine: Update 4-bit LFSR
# Implements primitive polynomial x^4 + x^3 + 1
# Taps at bit[3] and bit[2]
# LFSR state stored in s1
lfsr_update:
    # Get bit 3
    SRLI t3, s1, 3          # Shift right by 3 positions
    ANDI t3, t3, 0x01       # Mask to get only bit 3
    
    # Get bit 2
    SRLI t4, s1, 2          # Shift right by 2 positions
    ANDI t4, t4, 0x01       # Mask to get only bit 2
    
    # XOR the two taps to get feedback bit
    XOR  t3, t3, t4         # t3 = bit[3] XOR bit[2]
    
    # Shift LFSR left by 1 position
    SLLI s1, s1, 1          # Shift left
    
    # Insert feedback bit at LSB
    OR   s1, s1, t3         # Insert feedback bit
    
    # Mask to keep only 4 bits
    ANDI s1, s1, 0x0F       # Keep only lower 4 bits
    
    # Safety check: if LFSR is zero, reload seed
    BNE  s1, zero, lfsr_done
    LI   s1, 0x0F
    
lfsr_done:
    JALR zero, ra, 0        # Return

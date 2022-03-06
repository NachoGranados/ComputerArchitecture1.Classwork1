# Constant
addi s0, zero, 100       # iterMax

# Variable definition
addi s1, zero, 77        # state => M in ASCII
addi s2, zero, 0         # i
addi s3, zero, 0x100     # randomNumber

While:
    slt t0, s2, s0       # i < iterMax?
    beq t0, zero, 72     # i == 100?
    
    andi t1, s1,1        # output = state & 1
    
    slli t2, s2, 2       # i x 4
    add t2, t2, s3       # randomNumber[i]
    sw t1, 0(t2)         # randomNumber[i] = output
    
    srli t2, s1, 7       # state >> 7 => x^8
    srli t3, s1, 5       # state >> 5 => x^6
    srli t4, s1, 4       # state >> 4 => x^5
    srli t5, s1, 3       # state >> 3 => x^4
    
    xor t6, t2, t3       # (state >> 7) ^ (state >> 5)
    xor t6, t6, t4       # (state >> 7) ^ (state >> 5) ^ (state >> 4)
    xor t6, t6, t5       # (state >> 7) ^ (state >> 5) ^ (state >> 4) ^ (state >> 3)
    andi t6, t6, 1       # newbit = ((state >> 7) ^ (state >> 5) ^ (state >> 4) ^ (state >> 3)) & 1
    
    srli t0, s1, 1       # state >> 1
    slli t1, t6, 7       # newbit << 7
    or s1, t0, t1        # state = (state >> 1) | (newbit << 7)
    
    addi s2, s2, 1       # i++
    
    j While              # While loop
    
Exit:

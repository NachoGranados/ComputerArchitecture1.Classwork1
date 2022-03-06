# Constant
addi s0, zero, 100       # iterMax

# Variable definition
addi s1, zero, 77        # state => M in ASCII
addi s2, zero, 0         # i
addi s3, zero, 0x100     # randomNumber

While:
    slt t0, s2, s0       # i < iterMax?
    beq t0, zero, 80     # i == 100?
    
    slli t1, s2, 2       # i x 4
    add t1, t1, s3       # randomNumber[i]
    sw s1, 0(t1)         # randomNumber[i] = state
    
    andi t2, s1, 1       # state & 1 => x^8

    srli t3, s1, 2       # state >> 2
    andi t3, t3, 1       # (state >> 2) & 1 => x^6

    srli t4, s1, 3       # state >> 3
    andi t4, t4, 1       # (state >> 3) & 1 => x^5

    srli t5, s1, 4       # state >> 4
    andi t5, t5, 1       # (state >> 4) & 1 => x^4  
    
    xor t6, t2, t3       # (x^8) ^ (x^6)
    xor t6, t6, t4       # (x^8) ^ (x^6) ^ (x^5)
    xor t6, t6, t5       # (x^8) ^ (x^6) ^ (x^5) ^ (x^4)
    andi t6, t6, 1       # newbit = ((x^8) ^ (x^6) ^ (x^5) ^ (x^4)) & 1
    
    srli t0, s1, 1       # state >> 1
    slli t1, t6, 7       # newbit << 7
    or s1, t0, t1        # state = (state >> 1) | (newbit << 7)
    
    addi s2, s2, 1       # i++
    
    j While              # While loop
    
Exit:

nop
addi r1, r0, #42             # R1 = 0x2A (42 in hexadecimal)
addi r2, r0, #0xAAAA         # R2 = 0xFFFFAAAA Due to sign extend
nop                         
nop                         
nop                         
nop                         
nop                         
or r3, r1, r2               # R3 = 0xFFFFAAAA (bitwise OR of R1 and R2)
addi r1, r0,#2             # R1 = 0x2 (overwrites previous value)
nop                         
nop                         
nop                         
nop                         
nop  
sll r4, r3, r1              # R4 = 0xFFFEAAA8 (logical shift left by 2bits)
slli r5, r3,#2             # R5 =  0xFFFEAAA8 (logical shift left by 2bits)
nop                         
nop                         
nop                         
nop                         
nop 
srl r6, r5, r1              # R6 = 0x3FFFAAAA (logical shift right by 2bits)
srli r7, r4,#2             # R7 = 0x3FFFAAAA (logical shift right by 2bits)
addi r8, r0, 0x0AAA        # R8 = 0x0AAA
addi r2, r0, 0x0F0F        # R2 = 0x0F0F (unchanged)
nop                         
nop                         
nop                         
nop                          
ori r3, r2, 0x00F0          # R3 = 0x0FFF (bitwise OR with immediate)
addi r1, r0, #5              # R1 = 0x5 (overwrites previous value)
subi r6,r6, 0x0AAA        # R6 = 3FFFA000
sub  r7,r7,r8             # R7 = R7 - 0x0AAA = 0x3FFFA000
nop                         
nop                         
nop                         
nop                         
nop 
xor r2,r7,r7              #R2 = R7 XOR R7 = 0x00
xori r6,r3,0x0FFF         #R3 = R6 XOR 0x0FFF = 0x00
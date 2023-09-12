nop
addi r0,r0,#1
addi r1,r1,#2
addi r2,r2,#3
addi r3,r3,#4
addi r4,r4,#5
addi r5,r5,#6
addi r6,r6,#7
addi r7,r7,#8
addi r8,r8,#9
addi r9,r9,#10
addi r10,r10,#11
addi r11,r11,#12
addi r12,r12,#13
addi r22,r22,#1
addi r23,r23,#1
nop
nop
nop
nop
nop
#NOW I TEST THE SET CONDITION Instruction
sle r20,r0,r10    #IF R0<=R10 --> R2O = 1
slei r21,r1,#5    #IF r1<=5 --> R21 = 1

sle r22,r10,r0    # R22 = 0
sle r23,r9,r1     # R23 = 0

#GREATER EQUAL:
sge r24,r9,r3     # R24 = 1
sgei r25,r12,#100 # R25 = 0
sgei r26,r12,#1   # R26 = 1

#NOT EQUAL:
snei r27,r5,#6    # R27 = 0
snei r28,r5,#12   # R28 = 1
sne  r29,r2,r7    # R29 = 1
sne  r20,r20,r21  # R20 = 0 (because R20 = R21)  
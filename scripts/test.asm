nop
addi r0,r0,#1
ciclo: 
addi r1,r1,#2
addi r2,r2,#3
addi r3,r3,#4
addi r4,r4,#5
addi r5,r5,#6
addi r6,r6,#7
xor r0,r0,r0
xor r1,r1,r1
xor r2,r2,r2
xor r3,r3,r3
xor r4,r4,r4
xor r5,r5,r5
xor r6,r6,r6
nop
nop
nop
nop
nop
#NOW I WILL TRY THE BRANCH
#j ciclo; 
bnez r7,ciclo #we jump to addi r1,r1,#2 if r1 is 0

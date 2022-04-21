.text
Fib:
bge $a0, 2, j
li $v0, 1
jr $ra
j:
addiu $sp, $sp, -8
sw $a0, 0($sp)
sw $ra, 4($sp)
addi $a0, $a0, -1
jal Fib

addiu $sp, $sp, -1
sw $v0, 0($sp)
addi $a0, $a0, -1
jal Fib
sw $t0, 0($sp)
add $v0, $t0, $v0
addiu $sp, $sp, 4
lw $ra, 4($sp)
lw $a0, 0($sp)
addiu $sp, $sp, 8
jr $ra

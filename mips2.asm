.text
.globl main
main:
li $v0, 1
li $a0, 12			# set x = 12  x= a0
addiu $sp, $sp, -8
sw $a0, 0($sp)			 
sw $ra, 4($sp)			 

addi $a1, $a0, -5		# 2nd pram for simpleEx(x-5)
jal simpleEx			# y = simple (x,x-5)
add $s0, $s0, $v0			# set return to y

li $a0,14			#  pram1 for 2nd call
lw $a1, 0($sp) 			# pram 2 for 2nd call
jal simpleEx			# y = y+ simple (14,x)
add $s0, $s0, $v0 		# y = y + return

lw $ra, 4($sp)			# recover
lw $a0, 0($sp)
addiu $sp, $sp, 8
jr $ra

simpleEx:
li $t1, 7			# z = 7
li $v0, 1
sll $t0, $a1, 1			# t0 = y * 2
add $v0, $a0, $t0		# return value = x + 2 y
sub $v0, $v0, $t1		# return value = x + 2y - z
jr $ra

	
move $a0, $v0		
li $v0, 1
syscall
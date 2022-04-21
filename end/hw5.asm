.text
.globl main
main:

li $a0, 4
#n = a0
fib:
bgt $a0 ,1, else		# n> 1, do F(n)

beq $a0, 1, j1
li $v0, 1  			# F(0) = 1
jr $ra
j1:				# F(1) = 2
li $v0, 2
jr $ra

else:
addi $sp, $sp -8
sw $a0, 0($sp)				# stack
sw $ra, 4($sp)
add $a0, $a0, -1
jal fib
#v0 = 2*f(n-1)
#mul $v0, $v0, 2			# v0 = v0 *2
addiu $sp, $sp, -4
sw $v0, 0($sp)	
		
add $a0, $a0, -1
jal fib
#v0= 3* f(n-2)
lw $t0, 0($sp)			# load 2* f(n-1)
addi $sp, $sp, 4
mul $t0, $t0, 2			# 2 * f(n-1)
mul $v0, $v0, 3			# 3 * f(n-1)
add $v0, $t0, $v0		# sum

lw $ra, 4($sp)			# recover
lw $a0, 0($sp)
addi $sp, $sp, 8
jr $ra

move $a0, $v0
li $v0, 1
syscall
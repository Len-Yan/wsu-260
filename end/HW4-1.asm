.data
string: .space 64
char: .ascii "a"
.text
.globl main
main:
la $s0, string				# read string limit 64
li $a1, 64
move $a0, $s0
li $v0, 8				# ask read
syscall 

lbu $t1, char				# t1 = a
li $t4, 0 				# index loop
loop:
lbu $t0, 0($s0)				# t0 = current pointer on string
bne $t1, $t0, find			
addiu $t6, $t4, 0			# find index

find:
addi $s0, $s0, 1			# to next char in string
addiu $t4, $t4, 1	
beqz $t0, exit				# if next char in string = 0   quit
j loop
exit:

li $t3, 1
li $t4, 0				# index loop		
la $s0, string				# reload the string
loop2:
lbu $t0, 0($s0)				# t0 = current pointer on string
bne $t4, $t6, dele 			# if find index
#loop3:					#dele
sb $t3, 0($s0)				# space bar for replace "a" 
j exit1

dele:
addi $s0, $s0, 1			# to next char in string
addiu $t4, $t4, 1	
beqz $t0, exit1
j loop2
exit1:

li $v0, 4				# print
syscall
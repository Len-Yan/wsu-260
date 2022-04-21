.text
.globl main
main:
li $s0, 14			# k = 15	$a0 = k
li $t0,2			# check even
li $t3, 0			# index i = 0
li $t4, 0			# temp value
li $s1, 0			# sum of all n^2

loop:
li $t0,2			# check even set to % 2 everytime , becasue it will be destroyed when checking
bgt $t3, $s0, exit		# if index > k ,exit

andi $t0, $t3, 1		#check even put check result into t1

bne $t0, 0, go			# if not even, skip
mul $t4, $t3, $t3		# else, n^2 ,   $t4 = index ^2
add $s1, $s1, $t4		# sum 
go:
addiu $t3, $t3, 1		# i++
j loop
exit:
move $a0, $s1			#print
li $v0, 1
syscall
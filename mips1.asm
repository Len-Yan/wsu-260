.text
.globle main
	main:
	la $s0, array	
	li $t0, 0			# i
	LOOP1:
	beq $t0, 5, EXIT		# if i = 5 (loop 6 times)  quit
	li $v0, 5 			# read int
	syscall
	sw $s0, 0($v0)			# put in array
	addiu  $s0, $s0, 4		# go to next index?
	j LOOP1
	EXIT:
	
	li $t0, 0			# set i = 0
	la $t1, 0($s0)			# largest
	la $t2, 0($s0)			# 2nd largest
	LOOP2:
	beq $t0, 5, EXIT2		# if i = 5 (loop 6 times)  quit
	blt $s0, $t1, store1		# if array less than current lagers, go check t2
	sw $t1, 0($t2)			# store largest int to 2nd lagers t2
	sw $s0, 0($t1)			# store largest int to t1
	addiu $s0 $s0, 4
	store1:
	j LOOP2
	blt $s0, $t2, store2		# if skiped largest, compare 2nd largest
	sw $s0, 0($t2)			# store less large int to t2
	store2:
	addiu $s0 $s0, 4
	j LOOP2
	
	EXIT2:
	move $a0, $t2				# print 2nd largest
	li $v0, 1
	syscall
.data
	array: .space 24

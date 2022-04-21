# #Quicksort 
# 10; 2; 17; 9; 6; 4; 8
.data 
array: .word 10, 2, 17, 9, 6, 4, 8
.text
.globl main
main:
la $a0, array				# test
li $a1,0
li $a2,6
jal quicksort

quicksort:
addiu $sp, $sp, -16			# put stack 
sw $a0, 0($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)
sw $ra, 12($sp)

bge $a1, $a2, skip			# if ai(lo) >= a2(hi) skipe

jal partition				# p := partition(A, lo, hi)
move $s3, $v0				# save retun value in to p

move $a2, $s3				# quicksort(A, lo, p)
jal quicksort

addiu $t0, $s3, 1			# p + 1
lw $a2, 4($sp)				# load from original hi
move $a1, $t0
jal quicksort				# quicksort(A, p + 1, hi)

skip:
lw $ra, 12($sp)				# recover stack
lw $a2, 8($sp)
lw $a1, 4($sp)
lw $a0, 0($sp)
addiu $sp, $sp, 16
jr $ra

partition:
la $s0, 0($a0)				# load array

lw $t1, 0($s0)				# ini s1 = A[0]
li $t0, 0				# t0 = i
loop1:					# find the A[lo]
lw $t1, 0($s0)				# load A[i]
beq $t0, $a1, done
addiu $t0, $t0, 1			# i++
addiu $s0, $s0, 4			# to next number in array

done:

mul $t6, $a1, 4
addu $t6, $s0, $t6			# find address of pivot
lw $t7, 0($t6)				# set t7 = value of A[t6],   A[lo]

addi $t0, $a1, -1			# i := lo - 1	 t1 = lo - 1
addi $t3, $a2, 1			# j := hi + 1	 t3 = hi + 1

mul $t1, $t0, 4				
mul $t4, $t3, 4
addu $t1, $s0, $t1			# find address of A[i]
addu $t4, $s0, $t4			# find address of A[j]
lw $t2, 0($t1)
lw $t5, 0($t4)

LOOPe:
loopi:
bge $t2, $t7, exit1			# while A[i] < pivot
addi $t0, $t0, 1			# i := i + 1
addu $t1, $t1, 4
lw $t2, 0($t1)				# load value A[i] into t2
j loopi
exit1:

loopj:
ble $t5, $t7, exit2			# while A[j] > pivot
addi $t3, $t3, -1			# j := j - 1
add $t4, $t4, -1
lw $t5, 0($t4)				# load value A[j] into t5
j loopj
exit2:

blt $t1, $t3, swap			# if i >= j then
add $v0, $t3, 0				# return j
jr $ra

swap: 
lw $t2, 0($t1) 
lw $t5, 0($t4) 
sw $t2, 0($t4) 
sw $t5, 0($t1) 
j LOOPe


print:
la $s0, 0($a0)
li $t0, 0
loopp:
beq $s0, $zero, exit
lw $t1, 0($s0) 

move $a0, $t1
li $v0, 1
syscall

addiu $t0, $t0, 1
addiu $s0, $s0, 4

exit:
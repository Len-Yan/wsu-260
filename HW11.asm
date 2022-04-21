#display output: X+Y=Z
.data
array: .space 6
asciiZero: .byte '0'
exp: .byte 30
expBuffer: .space 60
expBufferlen: .word 0

.text
.globl main
######################
lui $t0, 0xffff			# turn on TC
lw $t1, 8($t0)
ori $t1, $t1, 0x0001		# flip last bit
sw $t1, 8($t0)			# put back value
lui $to, 0xffff			# trun on RC
lw $t1, 0($t0)
ori $t1, $t1, 0x0002
sw $t1, 0($t0)


##############
main:
jal input


input:
la $s0, array			# load array to s0
lb $s1, 0($s0)			# load address of s0 into s1
li $t2, 0			# loop time
mfc0 $t0, $12
lui $t0, 0xffff
LOOP:				# polling
lw $t1, 0($t0)			# t1 sotre content RC
andi $t2, $t1, 0x0001
beq $t2, $zero, LOOP		# check ready bit
lw $a0, 4($t0)			# load the key pressed


sb $a0, 0($s1)			# save the input from key to array
addiu $s1, $s1, 1		# move address of array to next one
addiu $t2, $t2, 1		# loop time +1
beq $t2, 4, do			# check looped 4 times, go do math
j LOOP				# otherwise go loop for more input

do:
jal math
jr $ra				# end

#...............end read
# X - "0" + Y = Z   0 = 48  9 = 57    '+ = 43'  '= = 61'
math:
lb $s2, 0($s0)				# reload the address of array into s2

#li $t2, 0 				# index loop
loop:
#lb $t3, 0($s1)				# t0 = current pointer on array

lb $a0, 0($s2)				
jal char2num				# convert
sb $v0,0($t5)				# sore vale of number X in to t5
add $s2, $s2, 2				# shift pointer of array to 'Y'
lb $a0, 0($s2)				#
jal char2num				# convert
sb $v0, 0($t6)				# sore vale of number Y in to t6

add $t7, $t5, $t6			# Z at $t7

blt $t7, 10, go				# if Z < 10, good to go
sub $t7, $t7, 10	
li $t6, 1	
	
lb $a0, 0($t6)				# additional storing of '1' if Z >= 10
jal num2char
add $s1, $s1, 1				# move to next byte in array for storing
sb $v0, 0($s1)				# save '1' into S1 array

go:
lb $a0, 0($t7)				#
jal num2char
add $s1, $s1, 1				# move to next byte in array for storing
sb $v0, 0($s1)				# save Z into S1 array
jr $ra

#................ polling print
print:
lui $t0, 0xffff
lb $a0, 0($s1)				# reload array again for print
LOOP1:
lw $t1, 8($t0)
andi $t2, $t1, 0x0001
beq $t2, $zero, LOOP1

sw $a0, 12($t0)
add $a0, $a0, 1				# go to next char in array
beq $a0, $zero, quit			# check if end of array
j LOOP1
quit:
jr $ra					# finsh


char2num:
lb $t0, asciiZero
subu $v0, $a0, $t0
jr $ra
num2char:
lb $t0, asciiZero
addu $v0, $a0, $t0
jr $ra






###########################
.ktext 0x80000080
sw $t0, k_save_t0			# store data
sw $t1, k_save_t1
sw $t2, k_save_t2
sw $t5, k_save_t5
sw $t6, k_save_t6
sw $t7, k_save_t7
sw $s0, k_save_s0
sw $s1, k_save_s1
sw $s2, k_save_s2
sw $a0, k_save_a0
sw $ra, k_save_ra

mfc0 $t0, $13				# cause check
andi $t1, $t0, 
beq $zero, $t1, back			# skip if not keyboard action












back:
lw $t0, k_save_t0			# restore
lw $t1, k_save_t1
lw $t2, k_save_t2
lw $t5, k_save_t5
lw $t6, k_save_t6
lw $t7, k_save_t7
lw $s0, k_save_s0
lw $s1, k_save_s1
lw $s2, k_save_s2
lw $a0, k_save_a0
lw $ra, k_save_ra


eret					#return to .text

.kdata
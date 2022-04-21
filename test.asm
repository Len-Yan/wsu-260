.data
z: .byte '0'
exp: .byte 30
a: '5'

.text
.globl main
main:
la $s1,z
la $s2, exp
la $s3, a

lw $t3, 0($s3)
add $t5, $s3, $s1



move $a0, $t5
li $v0, 1
syscall

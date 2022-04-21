.text
.globl main
main:
li $v0, 6
syscall

mov.s $f12, $f0
$f5 stores 1e^-3
li $v0, 2
syscall

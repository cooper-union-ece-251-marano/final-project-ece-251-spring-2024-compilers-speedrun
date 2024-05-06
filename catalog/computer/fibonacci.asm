#Fibonacci: calculates nth fibonacci number from $a0 and places it into $va
#Note: for n>7, the data memory runs out of space, so don't do that

addi $sp, $zero, -1
shft $sp, $sp, 8
not $sp, $sp           #sets $sp at 255

addi $s0, $zero, 5
add $a0, $zero, $s0
addi $at, $zero, 7     #$at will substitute for $ra
jump $zero, 9          #function call

add $s1, $zero, $va    #puts result of function into #s1
jump $zero, 39         #jump to end of program

addi $sp, $sp, -3
sw $at, 2($sp)
sw $a0, 1($sp)
sw $t0, 0($sp)         #pushing to stack

bne $a0, $zero, 3      #n==0 case
addi $va, $zero, 0
jump $zero, 34

addi $a0, $a0, -1      #n==1 case
bne $a0, $zero, 3
addi $va, $zero, 1
jump $zero, 34

addi $at, $zero, 7
addi $at, $at, 7
addi $at, $at, 7
addi $at, $at, 4
jump $zero, 9          #effectively jal to function start
addi $t0, $va, 0       #places fib(n-1) into $t0
addi $a0, $a0, -1

addi $at, $zero, 7
addi $at, $at, 7
addi $at, $at, 7
addi $at, $at, 7
addi $at, $at, 5
jump $zero, 9          #another jal to function start
addi $va, $t0, $va     #$va = fib(n-1) + fib(n-2)

lw $t0, 0($sp)
lw $a0, 1($sp)
lw $at, 2($sp)
addi $sp, $sp, 3       #popping off the stack

jump $at, 0            #effectively jr command

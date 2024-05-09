#Fibonacci: calculates nth fibonacci number from $a0 and places it into $va

addi $sp, $zero, -1
shft $sp, $sp, 12
not $sp, $sp           #sets $sp at 4095

addi $s0, $zero, 7
addi $s0, $zero, 7     #the immediates in lines 7 and 8 can be changed between 0 and 7 as inputs
add $a0, $zero, $s0
addi $at, $zero, 7     #$at will substitute for $ra
addi $at, $at, 2
jump $zero, 11         #function call

add $s1, $zero, $va    #puts result of function into #s1
jump $zero, 41         #jump to end of program

addi $sp, $sp, -3
sw $at, 2($sp)
sw $a0, 1($sp)
sw $t0, 0($sp)         #pushing to stack

bne $a0, $zero, 3      #n==0 case
addi $va, $zero, 0
jump $zero, 36

addi $a0, $a0, -1      #n==1 case
bne $a0, $zero, 3
addi $va, $zero, 1
jump $zero, 36

addi $at, $zero, 7
addi $at, $at, 7
addi $at, $at, 7
addi $at, $at, 6
jump $zero, 11         #effectively jal to function start
addi $t0, $va, 0       #places fib(n-1) into $t0
addi $a0, $a0, -1

addi $at, $zero, 7
addi $at, $at, 7
addi $at, $at, 7
addi $at, $at, 7
addi $at, $at, 7
jump $zero, 11         #another jal to function start
addi $va, $t0, $va     #$va = fib(n-1) + fib(n-2)

lw $t0, 0($sp)
lw $a0, 1($sp)
lw $at, 2($sp)
addi $sp, $sp, 3       #popping off the stack

jump $at, 0            #effectively jr command

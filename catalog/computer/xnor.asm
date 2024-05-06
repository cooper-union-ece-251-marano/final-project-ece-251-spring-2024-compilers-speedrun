#Xnor function: A program of a function that takes two variables $a0, $a1, and calculates the xnor of the two in $va

addi $s0, $zero, -6
shft $s0, $s0, 8
addi $s0, $s0, 4        #$s0 = 1111 1010 0000 0100

addi $s1, $zero, 3
shft $s1, $s1, 4
addi $s1, $s1, 5        #$s1 = 0000 0000 0011 0101

add $a0, $zero, $s0
add $a1, $zero, $s1
jump $zero, 11          #function call

add $s2, $zero, $va     #move resultto $s2
jump $zero, 14          #jump to end of program

xor $t1, $a0, $a1
not $va, $t1            #perform xnor operation
jump $zero, 9           #like jr command

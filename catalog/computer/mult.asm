#Muliplication: multiplies three non-negative numbers together using two for loops 

addi $s0, $zero, 7
addi $s1, $zero, 5
addi $s2, $zero, 3

add $t0, $zero, $s0    #set up outer loop bounds
add $t1, $zero, $s1    #set up inner loop bounds
add $t2, $zero, $zero  #result will be placed in $t2

add $t2, $t2, $s2
addi $t1, $t1, -1      #decrement inner loop
bne $t1, $zero, -2     #branch for inner loop

add $t1, $zero, $s1    #reset inner loop
addi $t0, $t0, -1      #decrement outer loop
bne $t0, $zero, -5     #branch for outer loop

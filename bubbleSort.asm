# Input data
li $v0, 5
syscall    #get the number of data(n) that will be sorted.

slti $t0, $v0, 1	#if the number of data < 1, terminate the program.
beq $t0, 1, Exit

add $s0, $v0, $zero	#store the number of data to $s0.
add $t0, $v0, $zero    #copy the number of data to $t0.
move $s1, $sp    #store the initial address of the $sp, so that we can get the boundary then.
addi $s4, $sp, 4   #store the initial address of the $sp + 4, so that we can print the data in stack easily

Input_Data:
addi $t0, $t0, -1 #decrement
li $v0, 5
syscall    #get the data
sw $v0, 0($sp)    #store the data to $sp
addi $sp, $sp, -4

bne $t0, $zero, Input_Data    #cycle, until we have inputed n data

beq $s0, 1, Exit	#if the number of data == 1, then needn't to sort.

addi $sp, $sp, 4

# Start Sorting
move $s2, $sp     #store the current address of the $sp.
#so that we can return to current address after we operate the data whose address is less than current $sp
add $t0, $zero, $zero    #initialize the number in $t0

addi $s3, $s0, -1

li $v0 30
syscall    #record current time
add $t8, $a0, $zero    #store current time

Cycle_1:
addi $t0, $t0, 1    #increment
	Cycle_2:
	lw $t1, 0($sp)
	lw $t2, 4($sp)	#load a[j] and a[j + 1] to registers
	slt $t4, $t1, $t2
	beq $t4, 1, Notswap	#if a[j] < a[j + 1], Notswap
		sw $t2, 0($sp)
		sw $t1, 4($sp)
	Notswap:
	addi $sp, $sp, 4
	bne $sp, $s1, Cycle_2
add $sp, $s2, $zero	# make $sp points to the address of the newest data angin
addi $s1, $s1, -4	# push forword the boundary
bne $t0, $s3, Cycle_1	#if $t0 != n - 1, goto Cycle_1

li $v0 30
syscall
sub $a0, $a0, $t8	#get the running time of the program
li $v0, 1
syscall		#print the running time of the program

li $v0, 11
addi $a0, $zero, 10
syscall		# print '\n'

add $t0, $zero, $zero    #initialize the number in  $t0
Print:		#print the data in stack, and examine if the data is sorted correctly
li $v0, 1
lw $a0, 0($sp)
syscall

li $v0, 11
addi $a0, $zero, 9
syscall		# print '\t'

addi $sp, $sp, 4
bne $sp, $s4, Print

addi $sp, $sp, -4

Exit:
li $v0, 10
syscall		# terminate the program








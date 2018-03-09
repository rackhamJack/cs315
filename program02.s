###########################################################
#		Program Description

###########################################################
#		Register Usage
#	$t0
#	$t1
#	$t2
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data
array:      .word 0 # holds the pointer to the array
length:     .word 0 # holds the size of the array
array_sum:  .word 0 # holds the sum of the array
###########################################################
		.text
main:

#initial allocate array call
jal allocate_array
la $t9 array
sw $v0 0($t9)
la $t9 length
sw $v0 0($t9)

la $t9 array
lw $a0 0($t9)
la $t9 0($t9)
lw $a0 0($t9)
jal read_array
la $t9 array_sum
sw $v0 0($t9)

la $t9 array
lw $a0 0($t9)





	li $v0, 10		#End Program
	syscall
###########################################################
###########################################################
#		Subprogram Description
#The first subprogram ‘allocate_array’ will ask user for an array 
#length and dynamically allocates an array of that length in heap.
# It receives no arguments IN and has two arguments OUT, the base 
#address of the array and the array length. Do not forget to validate 
#array length so it cannot be zero or negative numbers.

###########################################################
#		Arguments In and Out of subprogram
#
#	$v0 base address of the array
#	$v1 size of the new array
###########################################################
#		Register Usage
#	$t0 holds tmp input size
#	$t1 holds base address for array
############################################################
		.data

allocate_array_prompt_p:  .asciiz "please input a valid length (n>0): "
allocate_error_p:         .asciiz "Ivalid Length!/n"

###########################################################
		.text

allocate_array:

inputLength:

li $v0 4
la $a0 allocate_array_prompt_p
syscall

li $v0 5
syscall

blez $v0, error

move $t0,  $v0

li $v0 9
sll $a0, $t0, 2
syscall
b end

error:
li $v0 4
la $a0, allocate_error_p
syscall
b inputLength

end:
move $t1, $v1

	jr $ra	#return to calling location
###########################################################
###########################################################
#		Subprogram Description
#The second subprogram ‘read_values’ receives two arguments IN, 
#the array base address and the array length. It will ask user 
#inputs to fill out the entire array. Also, it should make sure 
#that each entered number is non-negative and divisible by both 
#3 and 4. It returns one argument OUT: the sum of valid numbers read.
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0 base array address
#	$a1 length of array
#	$v0 sum of array values
###########################################################
#		Register Usage
#	$t0 base address
#	$t1 length of array
#	$t2 temp sum
#	$t3 12
#	$t4 
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9 temp register
###########################################################
		.data
fill_array_prompt: .asciiz  "please enter a number that is noth nonnegative and divisible by 3 and 4"
fill_error:        .asciiz  "Invalid entry"
###########################################################
		.text
move $t0, $a0
move $t1, $a1
li $t3, 12
li $t2, 0

array_input:

li $v0, 4
la $a0 fill_array_promt
syscall

li $v0, 5
syscall

blez $v0, error
 
rem $t9, $v0, $t3
bnez $t9, error

add $t2, $t2, $v0
sw $v0, 0($t0)
addi $t0, $t0, 4
addi $t1, $t1, -1

beqz $t0, readEnd
b array_input

readEnd:
move $v0, $t2

	jr $ra	#return to calling location
###########################################################

###########################################################
#		Subprogram Description
#The third subprogram ‘print_backwards’ receives two arguments IN, 
#the base address of the array and the array length. It has no arguments 
#OUT. This subprogram should print out the array in reverse order.
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0 base array address
#	$a1 array length
#	$v0 nothing
###########################################################
#		Register Usage
#	$t0 base array address
#	$t1 array length
#	$t2 array bit length
##	$t6 4
############################################################
		.data
print_array_heading:  .asciiz "array printed backwards \n"


###########################################################
		.text
move $t0, $a0
move $t1, $a0
li $t6, 4
la $a0, print_array_heading
syscall

mul $t2, $t1, $t6
add $t0, $t0, $t2

printloop:

li $v0 1
move $a0 $t0
syscall

li $v0 11
syscall
addi $t0, $t0, -4
addi $t1, $t1, -1

bgtz $t1, printloop

printEnd:
	jr $ra	#return to calling location
###########################################################

###########################################################
#		Subprogram Description
#The fourth subprogram ‘print_average’ which receives as 
#arguments IN the ‘total’ and ‘count’ and has no arguments OUT. 
#It outputs the average of the numbers read to 4 decimal places 
#using only integer commands.

###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp
#	$sp+4
#	$sp+8
#	$sp+12
###########################################################
#		Register Usage
#	$t0
#	$t1
#	$t2
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data

###########################################################
		.text

	jr $ra	#return to calling location
###########################################################

###########################################################
#		Subprogram Description

###########################################################
#		Arguments In and Out of subprogram
#
#	$a0
#	$a1
#	$a2
#	$a3
#	$v0
#	$v1
#	$sp
#	$sp+4
#	$sp+8
#	$sp+12
###########################################################
#		Register Usage
#	$t0
#	$t1
#	$t2
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data

###########################################################
		.text

	jr $ra	#return to calling location
###########################################################


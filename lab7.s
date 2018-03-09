###########################################################
#	
#
#
#
#            	Collin Miller
#		Student ID# 990749190
#		Section# 802
#
#
#
#
#	Lab 7 Vector Dot Product
#
#	Description:
#		The purpose of this lab is to help you understand
#		subprogram re-use and practice for test 1 programming
#		part.
#
#		This program will ask user to input a length and
#		dynamically allocate two arrays of that length, you 
#		should store base address of two arrays and the array 
#		length in static variables (you only need one array length). 
#		Then ask user to fill those two arrays and print them
#		in console. Finally, it will calculate the vector
#		dot product of two array and print out the result.
#		(you should also store the dot product in static varialbe)
#
#		This lab should have ONE main program associate with
#		FOUR subprograms: allocate_array, read_array, print_array,
#		and vector_dot_product. you should use allocate_array
#		twice to dynamically allocate two array, also you will
#		need to use read_array and print_array twice.
#
#		Please see subprograms for detail requirements.
#
#	Hint:
#		you may want to finish all subprograms first then go
#		back and program main part.
#
###########################################################
#		Register Usage
#	$t0 list1 address
#	$t1
#	$t2 array length
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8     initial length (0)
#	$t9	temp register
###########################################################
		.data
create_vector_p:	.asciiz		"Creating vectors:\n"
list_1_prompt_p:	.asciiz		"\nPlease fill the first vector:\n"
list_2_prompt_p:	.asciiz		"\nPlease fill the second vector:\n"
list_1_p:			.asciiz		"\nVector 1: "
list_2_p:			.asciiz		"\nVector 2: "
dot_product_p:		.asciiz		"\nVector dot product:	"
list_1:		.word	0 #holds pointer to the first array
list_2:		.word	0 #holds the pointer to the second array
length:		.word	0 #holds size of the array
vec_dot:	.word	0
###########################################################
		.text
main:


li $v0, 4
la $a0, create_vector_p
syscall 

#call allocate_array for first time
li $a0, 0           #pass initial value of zero to trigger user prompt
jal allocate_array  #call subprogram

la $t9, list_1      #load address of list one into t9
sw $v0, 0($t9)      #store base address in the static variable
la $t9, length      #repeat for length
sw $v1, 0($t9)

#call allocate_array for second time
la $t9, length
lw $a0, 0($t9)      #load value of previously gotten length into a0
jal allocate_array  #subprogram is called but this time user will not be prompted
la $t9, list_2      
sw $v0, 0($t9)      #store base address of second array in the static variable list_2

li $v0 4
la $a0 list_1_prompt_p
syscall

#call read_array for first time
la $t9, list_1      #load stuff into args for subprogram
lw $a0, 0($t9)
la $t9, length
lw $a1, 0($t9)
jal read_array      #call subprogram this will fill the first array

li $v0, 4
la $a0, list_2_prompt_p
syscall

#call read_array for the second time
la $t9, list_2      #load stuff into args for subprogram
lw $a0, 0($t9)
la $t9, length
lw $a1, 0($t9)
jal read_array     #call subprogram. this will fill the second array

li $v0, 4
la $a0, list_1_p
syscall

#call print_array for list_1
la $t9, list_1      #load stuff into args for subprogram
lw $a0, 0($t9)
la $t9, length
lw $a1, 0($t9)
jal print_array      #call subprogram this will print list_1

li $v0 4
la $a0, list_2_p
syscall

#call print_array for list_2
la $t9, list_2      #load stuff into args for subprogram
lw $a0, 0($t9)
la $t9, length
lw $a1, 0($t9)
jal print_array     #call subprogram. this will print the second array

li $v0, 4
la $a0, dot_product_p
syscall 

#call for vecto_dot_product
la $t9, list_1      	#load both lists and the length into args for subprogram
lw $a0, 0($t9)
la $t9, list_2
lw $a1, 0($t9)
la $t9, length
lw $a2, 0($t9)
jal vector_dot_product 	#call vector dot product
la $t9, vec_dot
sw $v0, 0($t9)	   	#store the vector dot product in its static variable

main_end:
	li $v0, 10		#End Program
	syscall
###########################################################
###########################################################
#		allocate_array
#
#	Arguments:
#		- ONE argument IN:		$a0 <- array length
#		- TWO arguments OUT:	$v0 <- array base address
#								$v1 <- array length
#
#	Requirements:
#		- if argument IN is less or equal to zero, prompt
#		  user for a valid array length ( n > 0 ), and then
#		  use the user input to dynamically allocate an
#		  array.
#		- if argumetn IN is greater than zero, use the
#		  argument to dynamically allocate an array
#		- this subprogram should have TWO arguments OUT
#
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0	array length
#	$a1
#	$a2
#	$a3
#	$v0	base address
#	$v1	array length
###########################################################
#		Register Usage
#	$t0 initial length (0)	
#	$t1 holds temp input size	
#	$t2 holds array size address
#	$t3
#	$t4
#	$t5
#	$t6
#	$t7
#	$t8
#	$t9
###########################################################
		.data
allocate_array_prompt_p:	.asciiz	"Please input a valid length (n > 0): "
allocate_array_error_p:		.asciiz	"Invalid length!\n"
###########################################################
		.text
allocate_array:
move $t1, $a0

beqz $t1, inputLength
b allocate

inputLength:
li $v0 4
la $a0 allocate_array_prompt_p
syscall

li $v0 5
syscall

blez $v0, error

move $t1, $v0

allocate:
li $v0 9 ##call the allocate with the 9 and then multiplies the input stored in $t2 by 4 because ##ints take 4 bytes. When syscall runs this is the number of bytes used to allocate with

sll $a0, $t1, 2
syscall
b end

error:
li $v0 4
la $a0, allocate_array_error_p
b inputLength

end:
move $v1, $t1

	jr $ra							# return to calling location
###########################################################
###########################################################
#		read_array
#
#	Arguments:
#		- TWO arguments IN:		$a0 <- array base address
#						$a1 <- array length
#		- NO argument OUT
#
#	Requirement:
#		- ask user input any integer and fill out the array
#	
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0	array base address
#	$a1 array length
#	$a2
#	$a3
#	$v0
#	$v1
###########################################################
#		Register Usage
#	$t0	array base address
#	$t1	array length
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
read_array_prompt_p:	.asciiz	"Please input an INTEGER: "
###########################################################
		.text
read_array:
move $t0, $a0
move $t1, $a1

readInput:
li $v0 4
la $a0 read_array_prompt_p
syscall

li $v0 5
syscall

sw $v0, 0($t0)
addi $t0, $t0, 4
addi $t1, $t1, -1
bgtz $t1, readInput

	jr $ra							# return to calling location
###########################################################
###########################################################
#		print_array
#
#	Arguments:
#		- TWO arguments IN:		$a0 <- array base address
#								$a1 <- array size
#		- NO argument OUT
#
#	Requirements:
#		- print all element inside array separate by 'space'
#		- you should use system call 11 to print 'space'
#		  character (asciiz code 32)
#	
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0	array base address
#	$a1 array length
#	$a2
#	$a3
#	$v0
#	$v1
###########################################################
#		Register Usage
#	$t0	array base address
#	$t1	array length
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
print_array:
move $t0, $a0
move $t1, $a1

print_loop:

li $v0 1
lw $a0, 0($t0)
syscall

li $v0 11
syscall

addi $t0, $t0, 4
addi $t1, $t1, -1
bgtz $t1, print_loop

	jr $ra							# return to calling location
###########################################################

###########################################################
#		vector_dot_product
#
#	Arguments:
#		- THREE arguments IN:	$a0 <- base address of list 1
#					$a1 <- base address of list 2
#					$a2 <- array length
#		
#		- ONE argument OUT:	$v0 <- dot product of list 1 & list 2
#
#	Hint:
#					   
#		[1, 3, -5] * [4, -2, -1  ] = (1 * 4) + (3 * -2) + (-5 * -1) = 3
#					   
###########################################################
#		Arguments In and Out of subprogram
#
#	$a0	base address of list 1
#	$a1 base address of list 2
#	$a2	array length
#	$a3
#	$v0	dot product
#	$v1
###########################################################
#		Register Usage
#	$t0 base address of list 1
#	$t1	base address of list 2
#	$t2	array length
#	$t3	list_1[current]
#	$t4 list_2[current]
#	$t5 product of list_1[current] & list_2[current]
#	$t6 sum of products eventuall the dot product
#	$t7
#	$t8
#	$t9
###########################################################
		.data

###########################################################
		.text
vector_dot_product:
move $t0, $a0
move $t1, $a1
move $t2, $a2
li $t6, 0

calcLoop:
lw $t3, 0($t0)          #load the currnt list values
lw $t4, 0($t1)
mul $t5, $t3, $t4       #find the product
add $t6, $t6, $t5       #add the product to the previous sums

addi $t0, $t0, 4        #increment the arrays
addi $t1, $t1, 4
addi $t2, $t2, -1	#decrement the size counter

bgtz $t2, calcLoop	#check to see if the loop should continue
move $v0, $t6		#transfer the final sum to the return registry

li $v0 1		#print the vector dot product
move $a0, $t6
syscall			


	jr $ra							# return to calling location
###########################################################


.section .text
.global switch_to_longmode
.type 	switch_to_longmode, @function
switch_to_longmode:
	xchgw	%bx, %bx

	movl	%cr0, %ecx
	andl	$0x7FFFFFFF, %ecx
	movl	%ecx, %cr0

	# TODO: 
	#	* Setup IA-32e paging structures
	#	* Set CR4.PAE 
	#	* Load CR3 with PML4 address
	# 	* IA32_EFER.LME = 1 to enable IA-32e
	#	* Enable paging with CR0.PG

	ret

# Summit OS
# Marcelino Coll 2016
# file: boot.S


# Declare constants for the multiboot header.
.set ALIGN,    1<<0             # align loaded modules on page boundaries
.set MEMINFO,  1<<1             # provide memory map
.set FLAGS,    ALIGN | MEMINFO  # this is the Multiboot 'flag' field
.set MAGIC,    0x1BADB002       # 'magic number' lets bootloader find the header
.set CHECKSUM, -(MAGIC + FLAGS) # checksum of above, to prove we are multiboot


# Declare a multiboot header that marks the program as a kernel.
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM


# Allocate the initial stack.
.section .bootstrap_stack, "aw", @nobits
stack_bottom:
.skip 16384 # 16 KiB
stack_top:



# The kernel entry point.
.section .text
.global _start
.type _start, @function
_start:
	movl	$stack_top, %esp
	# Switch to protected mode to prepare 
	# for long mode switch
	call 	switch_to_protmode

	# Switch to long mode
	# call 	switch_to_longmode

	xchgw	%bx, %bx

	# Infinite loop if the system has nothing more to do.
	cli
5:	hlt
	jmp 5b

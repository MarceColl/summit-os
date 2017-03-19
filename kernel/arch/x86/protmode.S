# Summit OS
# Marcelino Coll Rovira 2016-2017
# file: protmode.S


.section .bss, "aw", @nobits
.align 4096
boot_pagedir:
	.skip 4096
boot_pagetab1:
	.skip 4096
	.skip 4096


.section .text
.type setup_protmode_paging, @function
setup_protmode_paging:
	

	# Setup paging
	movl 	%cr0, %ecx
	orl 	$0x80010000, %ecx
	movl 	%ecx, %cr0
	ret


.section .text
.type setup_protmode_gdt, @function
setup_protmode_gdt:
	lgdt	(gdt_info)
	ret


.section .text
.type setup_protmode_idt, @function
setup_protmode_idt:
	call	idt_setup
	lidt	(idt_info)
	ret


.section .text
.global switch_to_protmode
.type switch_to_protmode, @function
switch_to_protmode:
	# Initialization of the protected mode
	# paging structures, we only need to
	# identity page the kernel as we
	# only need this in order to switch to
	# long mode
	call 	setup_protmode_paging

	# Initialization of the protected mode 
	# global descriptor table
	call 	setup_protmode_gdt

	# Initialization of the protected mode
	# interrupt descriptor table
	call 	setup_protmode_idt

	# Switch to Protected mode
	movl	%cr0, %ecx
	orl	$0x00000001, %ecx
	movl	%ecx, %cr0

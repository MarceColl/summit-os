# Summit OS
# Marcelino Coll Rovira 2016-2017
# file: protmode.S

.equ	VIRTUAL_BASE, 0xFFFFFFFF80000000

.code64
.section .bss, "aw", @nobits
.align 4096
boot_pagedir:
	.skip 4096
boot_pagetab1:
	.skip 4096


.section .text
.type setup_protmode_paging, @function
setup_protmode_paging:
	movq 	$(boot_pagetab1 - VIRTUAL_BASE), %rdi
	movq	$0x0, %rsi

1:
	cmpq	$(_kernel_start - VIRTUAL_BASE), %rsi
	jl	2f
	cmpq	$(_kernel_end - VIRTUAL_BASE), %rsi
	jge	3f

	movq	%rsi, %rdx
	orq	$0x003, %rdx
	movq	%rdx, (%rdi)

2:
	addq	$4096, %rsi
	addq	$4, %rdi
	loop 	1b

3:
	movq	$(boot_pagetab1 - VIRTUAL_BASE + 0x003), boot_pagedir - VIRTUAL_BASE
	movq 	$(boot_pagedir - VIRTUAL_BASE), %rcx
	movq	%rcx, %cr3

	# Enable paging bit (31) in cr0
	movq 	%cr0, %rdx
	orl 	$0x80000000, %edx
	movq 	%rdx, %cr0

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
	# global descriptor table
	call 	setup_protmode_gdt

	# Initialization of the protected mode
	# interrupt descriptor table
	call 	setup_protmode_idt

	# Initialization of the protected mode
	# paging structures, we only need to
	# identity page the kernel as we
	# only need this in order to switch to
	# long mode
	call 	setup_protmode_paging

	ret

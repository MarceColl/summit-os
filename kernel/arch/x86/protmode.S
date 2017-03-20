# Summit OS
# Marcelino Coll Rovira 2016-2017
# file: protmode.S

.equ	VIRTUAL_BASE, 0xC0000000


.section .bss, "aw", @nobits
.align 4096
boot_pagedir:
	.skip 4096
boot_pagetab1:
	.skip 4096


.section .text
.type setup_protmode_paging, @function
setup_protmode_paging:
	movl 	$(boot_pagetab1 - VIRTUAL_BASE), %edi
	movl	$0x0, %esi

1:
	cmpl	$(_kernel_start - VIRTUAL_BASE), %esi
	jl	2f
	cmpl	$(_kernel_end - VIRTUAL_BASE), %esi
	jge	3f

	movl	%esi, %edx
	orl	$0x003, %edx
	movl	%edx, (%edi)

2:
	addl	$4096, %esi
	addl	$4, %edi
	loop 	1b

3:
	movl	$(boot_pagetab1 - VIRTUAL_BASE + 0x003), boot_pagedir - VIRTUAL_BASE
	movl 	$(boot_pagedir - VIRTUAL_BASE), %ecx
	movl	%ecx, %cr3

	# Enable paging bit (31) in cr0
	movl 	%cr0, %ecx
	orl 	$0x80000000, %ecx
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

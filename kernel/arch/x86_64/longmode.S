.section .bss, "aw", @nobits
.align 4096
kernel_PML4:
	.skip 4096
kernel_PDPTE:
	.skip 4096
kernel_PDE:
	.skip 4096
kernel_PTE:
	.skip 4096

.code64
.section .text
.type setup_longmode_gdt, @function
setup_longmode_gdt:
	ret


.section .text
.type setup_longmode_idt, @function
setup_longmode_idt:
	ret


.section .text
.type setup_longmode_paging, @function
setup_longmode_paging:
	ret


.section .text
.global switch_to_longmode
.type 	switch_to_longmode, @function
switch_to_longmode:
	# Disable paging
	mov	%cr0, %rcx
	andl	$0x7FFFFFFF, %ecx
	mov	%rcx, %cr0

	# Setup of the longmode GDT
	call setup_longmode_gdt

	# Setup of the longmode IDT
	call setup_longmode_idt

	# Setup of the longmode Paging
	call setup_longmode_paging

	# TODO: 
	#	* Setup IA-32e paging structures
	#	* Set CR4.PAE 
	#	* Load CR3 with PML4 address
	# 	* IA32_EFER.LME = 1 to enable IA-32e
	#	* Enable paging with CR0.PG

	xchgw	%bx, %bx
	rdmsr
	orq	$0x0000000000000080, %rdx
	wrmsr

	ret

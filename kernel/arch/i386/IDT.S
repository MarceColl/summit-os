# IDT.S - Summit OS
# Interrupt Descriptor Table
# Marcelino Coll Rovira

.section .text
int_handler:
	movl $0x123abc, 0xC03FF000
	iret


.globl irpt_test
irpt_test:
	xchg %bx, %bx
	movl $int_handler, %eax
	mov %ax, idt_start+0*16
	movw $0x10, idt_start+0*16+2
	movw $0x8e00, idt_start+0*16+4
	shr $16, %eax
	mov %ax, idt_start+0*16+6
	shr $16, %eax
	mov %eax, idt_start+0*16+8
	int $0x00	


.section .data
.p2align 4
idt_start:
	.skip 50*16	


.globl idt_info
idt_info:
	.word idt_info - idt_start - 1
	.long idt_start

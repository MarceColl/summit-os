ENTRY (_start)

SECTIONS
{
	/* The kernel will live at 3GB + 1MB in the virtual address space, */
	/* which will be mapped to 1MB in the physical address space. */
	/* Note that we page-align the sections. */
	. = 0x0100000;

	/* Add a symbol that indicates the start address of the kernel. */
	_kernel_start = .;
	.text ALIGN (4K) : AT (ADDR (.text) )
	{
		*(.multiboot)
		*(.text)
	}
	.rodata ALIGN (4K) : AT (ADDR (.rodata))
	{
		*(.rodata)
	}
	.data ALIGN (4K) : AT (ADDR (.data))
	{
		*(.data)
	}
	.bss ALIGN (4K) : AT (ADDR (.bss))
	{
		*(COMMON)
		*(.bss)
		*(.bootstrap_stack)
	}

	/* Add a symbol that indicates the end address of the kernel. */
	_kernel_end = .;
}

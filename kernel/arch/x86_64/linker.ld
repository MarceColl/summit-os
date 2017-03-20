ENTRY (_start)

VIRTUAL_BASE = 0xFFFFFFFF80000000;

SECTIONS
{
	.multiboot : ALIGN (4K)
	{
		*(.multiboot)
	}

	. = 0x0100000;

	_kernel_start = VIRTUAL_BASE + .;
	.boot :
	{
		_code = .;
		*(.boot)
	}

	. += VIRTUAL_BASE;
	.text ALIGN (0x1000) : AT (ADDR (.text) - VIRTUAL_BASE)
	{
		_data = .;
		*(.text)
		*(.bootstrap_stack)
	}
	.rodata ALIGN (4K) : AT (ADDR (.rodata) - VIRTUAL_BASE)
	{
		*(.rodata)
	}
	.data ALIGN (4K) : AT (ADDR (.data) - VIRTUAL_BASE)
	{
		*(.data)
	}
	.bss ALIGN (4K) : AT (ADDR (.bss) - VIRTUAL_BASE)
	{
		_bss = .;
		*(.bss)
		*(COMMON)
	}

	_kernel_end = .;
}

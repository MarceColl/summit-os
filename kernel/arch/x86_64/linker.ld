ENTRY (_start)

VIRTUAL_BASE = 0xFFFFFFFF80000000;
PHYSICAL_BASE = 0x0000000000100000;

SECTIONS
{
	.multiboot : ALIGN (4K)
	{
		*(.multiboot)
	}

	. = PHYSICAL_BASE;

	_kernel_start = VIRTUAL_BASE + .;
	.boot :
	{
		_boot = .;
		*(.boot)
		arch/x86_64/boot.o (.text)
		arch/x86_64/longmode.o (.text)
		arch/x86_64/protmode.o (.text)
		arch/x86_64/protmode.o (.bss)
		arch/x86_64/GDT.o (.text)
		arch/x86_64/GDT.o (.data)
		arch/x86_64/IDT.o (.text)
		arch/x86_64/IDT.o (.data)
		arch/x86_64/crti.o (.text)
		*(.bootstrap_stack)
		*(.init)
		*(.fini)
		*(.jcr)
		*(.ctors)
		*(.dtors)
	}

	. = VIRTUAL_BASE + PHYSICAL_BASE;
	.text ALIGN (4K) : AT (ADDR (.text) - VIRTUAL_BASE)
	{
		_code = .;
		*(.text)
	}
	.rodata ALIGN (4K) : AT (ADDR (.rodata) - VIRTUAL_BASE)
	{
		_rodata = .;
		*(.rodata)
	}
	.data ALIGN (4K) : AT (ADDR (.data) - VIRTUAL_BASE)
	{
		_data = .;
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

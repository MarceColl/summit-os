# GDT.S - Summit OS
# Global Descriptor Table
# Marcelino Coll Rovira

# GDT ENTRY SCHEME
# -----------------------------------------------------------------------
# | 31                            16 | 15                             0 |
# |             Base 0:15            |            Limit 0:15            |
# |------------+-------+-------------|----------------------------------|
# | 63          56 | 55  52 | 51  48 |47           40 | 39           32 |
# |                |        | Limit  |                |                 |
# |   Base 24:31   | Flags  | 16:19  |   Access Byte  |   Base 16:23    |
# -----------------------------------------------------------------------
 
.code32
.section .data
.align 8
gdt_start:
	# NULL descriptor
	.long 0x0
	.long 0x0
	

	###############
	# Kernel Data # All memory, data, write
	###############
	.word 0xFFFF # Limit 0:15
	.word 0x0 # Base 0:15
	# Base 16:23 | Access Byte.
	# 00000000   | 0 1 0 0 1 00 1
	#              | | | | | |  |
	#              | | | | | |  Present bit, always 1
	#              | | | | | Privilege, ring level. 0 = kernel (highest), 3 = user apps (lowest)
	#              | | | | Always 1
	#              | | | Executable bit, 1 if executable, 0 if data
	#              | | Direction bit/Conforming bit, 0 grows up, 1 grows down for data. 1 this segment can be executed
	#              | | from an equal or lower privilege level than the privilege. 0 and can only be accessed by privilege.
	#              | RW bit, when data if write access is enabled, for code if read access is allowed.
	#              Ac bit. Just set to 0, CPU sets this to 1 when segment is accessed
	.word 0x9200
	# Limit 16:19 | Flags | Base 24:31.
	# 0000        | 1 1 00
	#               | | |
	#               | | Always 0
	#               | Size bit, if 0 defines 16 bit protected mode, if 1 32 bit protected mode
	#               Granularity bit, if 0 limit is in 1B blocks, if 1 in 4KiB blocks (page granularity)
	.word 0x00CF


	###############
	# Kernel Code # All memory, code, read
	###############
	.word 0xFFFF # Limit 0:15
	.word 0x0 # Base 0:15
	# Base 16:23 | Access Byte.
	# 00000000   | 0 1 0 1 1 00 1
	#              | | | | | |  |
	#              | | | | | |  Present bit, always 1
	#              | | | | | Privilege, ring level. 0 = kernel (highest), 3 = user apps (lowest)
	#              | | | | Always 1
	#              | | | Executable bit, 1 if executable, 0 if data
	#              | | Direction bit/Conforming bit, 0 grows up, 1 grows down for data. 1 this segment can be executed
	#              | | from an equal or lower privilege level than the privilege. 0 and can only be accessed by privilege.
	#              | RW bit, when data if write access is enabled, for code if read access is allowed.
	#              Ac bit. Just set to 0, CPU sets this to 1 when segment is accessed
	.word 0x9A00
	# Limit 16:19 | Flags | Base 24:31.
	# 0000        | 1 1 00
	#               | | |
	#               | | Always 0
	#               | Size bit, if 0 defines 16 bit protected mode, if 1 32 bit protected mode
	#               Granularity bit, if 0 limit is in 1B blocks, if 1 in 4KiB blocks (page granularity)
	.word 0x00CF


.globl gdt_info
.align 8
gdt_info:
	.word gdt_info - gdt_start - 1
	.long gdt_start

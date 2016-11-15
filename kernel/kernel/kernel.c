#include <stdio.h>

#include <kernel/tty.h>

void kernel_main(void) {
	terminal_initialize();
	printf("Hello, kernel World!\n");

	for(int i = 0; i < 200000; ++i) {
		printf("%d", i);
	}
}
#include <stdio.h>

#include <kernel/tty.h>


void print_banner() {
	printf("  ____                            _ _      ___  ____  \n");
	printf(" / ___| _   _ _ __ ___  _ __ ___ (_) |_   / _ \\/ ___| \n");
	printf(" \\___ \\| | | | '_ ` _ \\| '_ ` _ \\| | __| | | | \\___ \\ \n");
	printf("  ___) | |_| | | | | | | | | | | | | |_  | |_| |___) |\n");
	printf(" |____/ \\__,_|_| |_| |_|_| |_| |_|_|\\__|  \\___/|____/  v0.0.1\n\n");
	printf("(c) 2016 Marcelino Coll\n");	
}


void kernel_main(void) {
	terminal_initialize();
	print_banner();
}
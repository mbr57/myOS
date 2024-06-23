#include <interrupts.h>
#include <vga.h>

#define PIC1_COMMAND 0x20
#define PIC2_COMMAND 0xa0
#define PIC1_DATA 0x21
#define PIC2_DATA 0xa1

void _start()
{
	int i;

	/* disable the cursor */
	asm("mov dx, 0x3d4\n"
	    "mov al, 0x0a\n"
		"out dx, al\n"
		"mov al, 0x20\n"
		"inc dx\n"
	    "out dx, al\n");
	
	/* clear the screen */
	cls(0, VGA_BLUE << 4);
	
	print(1, 1, "Kernel has started.", (VGA_BLUE << 4) | (VGA_GREY | VGA_LIGHT));
	
	set_handler(0, div0_handler);
	for (i = 1; i < 256; i++)
		set_handler(i, default_handler);
	set_handler(0x21, keyboard_handler); 
	setup_idt();
	
	asm("sti\n"); /* now, enable hardward interrupts */
	
	i = i / 0; /* division by zero exception - div0_handler should be called */
	
	while (1) ;
}

#include <exceptions.h>
#include <vga.h>

void _start()
{
	int i;
	cls(0, VGA_BLUE << 4);
	print(1, 1, "Kernel has started.", (VGA_BLUE << 4) | (VGA_GREY | VGA_LIGHT));
	
	set_exception_handler(0, div0_handler);
	for (i = 1; i < 32; i++)
		set_exception_handler(i, default_handler);
	setup_idt();
	
	i = i / 0; /* division by zero exception - div0_handler should be called */
	
	while (1) ;
}

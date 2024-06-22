#include <vga.h>

void _start()
{
	cls(0, VGA_BLUE << 4);
	print(1, 1, "Kernel has started.", (VGA_BLUE << 4) | (VGA_GREY | VGA_LIGHT));
	while (1) ;
}

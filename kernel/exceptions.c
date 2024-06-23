#include <exceptions.h>
#include <vga.h>

void div0_handler()
{
	print(3, 3, "Division by 0", (VGA_BLUE << 4) | (VGA_RED | VGA_LIGHT));
}

void default_handler()
{
	print(3, 3, "Default exception handler", (VGA_BLUE << 4) | (VGA_RED | VGA_LIGHT));
}

/* set up a particular exception handler */
void set_exception_handler(int entry, void *handler, char attributes)
{
	struct idt_entry *p = (struct idt_entry *)(8 * entry);
	p->offset_low = (unsigned int)handler & 0xffff;
	p->selector = 0x08;
	p->reserved = 0;
	p->attributes = attributes;
	p->offset_high = (unsigned int)handler >> 16;
}
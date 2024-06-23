#include <exceptions.h>
#include <vga.h>

/*
 * I haven't figured out how to declare a function as an interrupt handler
 * (so that it uses the iret instruction instead of ret) with Smaller C
 * compiler. Therefore we use wrapper handlers written in assembly
 * (as defined in wrappers.asm) which will call the proper handler
 * and return correctly with iret. Pointers to the handlers are stored
 * in the 'handlers' array. Pointers to wrapper functions are also stored
 * in an array ('wrappers'), but that's only for convenience purposes.
 */
 
extern void set_up_wrappers_table();

/* array of pointers to the exception handlers */
void *handlers[32];

/* array of pointers to the wrappers */
/* it is filled with set_up_wrappers_table() (wrappers.asm) */
void *wrappers[32];

/* division by 0 exception handler */
void div0_handler()
{
	print(3, 3, "exception: division by zero", (VGA_BLUE << 4) | (VGA_RED | VGA_LIGHT));
}

/* exception handler used by default */
void default_handler()
{
	print(3, 3, "default exception handler", (VGA_BLUE << 4) | (VGA_RED | VGA_LIGHT));
}

/* this should set up the IDT with the offsets of the wrappers */
void setup_idt()
{
	struct idt_entry *p = (struct idt_entry *)0;
	int i;
	
	set_up_wrappers_table();
	
	for (i = 0; i < 5; i++) {
		p->offset_low = (unsigned int)wrappers[i] & 0xffff;
		p->selector = 0x08;
		p->reserved = 0;
		p->attributes = 0x8f;
		p->offset_high = (unsigned int)wrappers[i] >> 16;
		p++;
	}
}

/* set up a particular exception handler */
void set_exception_handler(int entry, void *handler)
{
	handlers[entry] = handler;
}
#include <interrupts.h>
#include <tty.h>
#include <vga.h>

#define INT_NUM 256

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
extern int current_tty;

/* array of pointers to the interrupt handlers */
void *handlers[INT_NUM];

/* array of pointers to the wrappers */
/* it is filled with set_up_wrappers_table() (wrappers.asm) */
void *wrappers[INT_NUM];

/* division by 0 exception handler */
void div0_handler()
{
    tty_print(0, "Exception: division by zero.\n");
}

void pf_handler()
{
    tty_print(0, "Exception: page fault.\n");
}

static unsigned char scancode;

void keyboard_handler()
{
    asm("in al, 0x60\n"
        "mov byte [_scancode], al\n");
    if (scancode >= 0x10 && scancode < 0x15)
        tty_switch(scancode - 0x10);
    tty_print(4, "Keyboard interrupt\n");
}

/* interrupt handler used by default */
void default_handler()
{
    tty_print(1, "Default handler.\n\n");
}

/* this should set up the IDT with the offsets of the wrappers */
void setup_idt()
{
    struct idt_entry *p = (struct idt_entry *)0;
    int i;
    
    set_up_wrappers_table();
    
    for (i = 0; i < INT_NUM; i++) {
        p->offset_low = (unsigned int)wrappers[i] & 0xffff;
        p->selector = 0x08;
        p->reserved = 0;
        p->attributes = 0x8f;
        p->offset_high = (unsigned int)wrappers[i] >> 16;
        p++;
    }
}

void set_idt_attributes(int entry, unsigned char attributes)
{
    struct idt_entry *p = (struct idt_entry *)(entry * 8);
    p->attributes = attributes;
}

/* set up a particular interrupt handler */
void set_handler(int entry, void *handler)
{
    handlers[entry] = handler;
}
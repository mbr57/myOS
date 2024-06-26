#include <interrupts.h>
#include <tty.h>
#include <vga.h>

char pic1_m, pic2_m;

void _start()
{
    int i;
    unsigned char x;
    unsigned int ptr = div0_handler;
    
    vga_clear_screen(TEXT_MEM, 0, DEFAULT_ATTR);

    for (i = 0; i < 5; i++)
        tty_init(i);
    tty_init(3);

    /* set up the handlers and the IDT */
    for (i = 0; i < 256; i++) {
        set_handler(i, default_handler);
    }
    set_handler(0, div0_handler);
    set_handler(0xe, pf_handler);
    set_handler(0x21, keyboard_handler); /* for keyboard IRQ */
    
    setup_idt();

    /* mask no IRQ */
    asm("mov al, 0\n"
        "out 0x21, al\n"
        "jmp $ + 2\n"
        "jmp $ + 2\n"
        "out 0xa1, al\n"
        "jmp $ + 2\n"
        "jmp $ + 2\n");

    /* get the new PIC masks (for debugging purposes) */
    asm("in al, 0x21\n"
        "mov byte [_pic1_m], al\n"
        "jmp $ + 2\n"
        "jmp $ + 2\n"
        "in al, 0xa1\n"
        "mov byte [_pic2_m], al\n"
        "jmp $ + 2\n"
        "jmp $ + 2\n");


    asm("sti\n"); /* enable hardware interrupts */

    tty_print(0,"Kernel has started\nThis is a text line\n");
    tty_print(0,"This is another text line.\n");

    tty_print(2, "tty2\n\nmyOS kernel\n");

    x = 0;
    while (1) {
        //tty_print(0,"This is another text line.\n");
        x++;
    }
}

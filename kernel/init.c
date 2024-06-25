#include <interrupts.h>
#include <vga.h>

#define DEFAULT_ATTR (VGA_BLUE << 4) | (VGA_GREY | VGA_LIGHT)

char pic1_m, pic2_m;

void _start()
{
    int i;
    unsigned char x;
    unsigned int ptr = div0_handler;
    
    /* disable the cursor */
    asm("mov dx, 0x3d4\n"
        "mov al, 0x0a\n"
        "out dx, al\n"
        "mov al, 0x20\n"
        "inc dx\n"
        "out dx, al\n");
    
    /* clear the screen */
    cls(0, VGA_BLUE << 4);
    
    print(1, 1, "Kernel has started.", DEFAULT_ATTR);

    /* set up the handlers and the IDT */
    set_handler(0, div0_handler);
    for (i = 1; i < 256; i++) {
        set_handler(i, default_handler);
    }
    
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

    print(1, 9, "PIC1 mask: ", DEFAULT_ATTR);
    print_hex(12, 9, pic1_m, DEFAULT_ATTR);
    print(1, 10, "PIC2 mask: ", DEFAULT_ATTR);
    print_hex(12, 10, pic2_m, DEFAULT_ATTR);

    asm("sti\n"); /* enable hardware interrupts */

    x = 0;
    while (1) {
        print_hex(20, 20, x, VGA_BLUE << 4 | VGA_GREEN);
        x++;
    }
}

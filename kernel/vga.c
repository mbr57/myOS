#include <vga.h>

/*
 * Here are some VGA text mode functions
 */

static char hex_digits[] = "0123456789ABCDEF";

void vga_clear_screen(char *buffer, char c, attr_t a)
{
	int i = 0;
	
	while (i < 2 * TEXT_SCREENS) {
		*((char *)(buffer + i++)) = c;
		*((char *)(buffer + i++)) = a;
	}
}

void vga_disable_cursor()
{
    asm("mov dx, 0x3d4\n"
        "mov al, 0x0a\n"
        "out dx, al\n"
        "mov al, 0x20\n"
        "inc dx\n"
        "out dx, al\n");
}

void vga_move_cursor(int x, int y)
{
    unsigned short pos = TEXT_SCREENW * y + x;
    asm("mov bx, word [ebp - 4]\n"
        "mov dx, 0x3d4\n"
        "mov al, 0x0f\n"
        "out dx, al\n"
        "inc dx\n"
        "mov al, bl\n"
        "out dx, al\n"
        "dec dx\n"
        "mov al, 0x0e\n"
        "out dx, al\n"
        "inc dx\n"
        "mov al, bh\n"
        "out dx, al\n");
}

void vga_putchar(char *buffer, int x, int y, char c, attr_t a)
{
	char *p = (char *)(buffer + 2 * (TEXT_SCREENW * y + x));
	
	*p = c;
	*(p + 1) = a;
}

void vga_print(char *buffer, int x, int y, char *s, attr_t a)
{
	char *p = (char *)(buffer + 2 * (TEXT_SCREENW * y + x));
	
	while (*s) {
		*(p++) = *(s++);
		*(p++) = a;
	}
}

void vga_print_hex(char *buffer, int x, int y, unsigned char n, attr_t a)
{
    char *p = (char *)(buffer + 2 * (TEXT_SCREENW * y + x));
    
    *(p++) = hex_digits[n >> 4];
    *(p++) = a;
    *(p++) = hex_digits[n & 15];
    *(p++) = a;
}

void vga_copy(char *buffer)
{
    unsigned short *src = (unsigned short *)buffer;
    unsigned short *dest = (unsigned short *)TEXT_MEM;
    int i;

    for (i = 0; i < TEXT_SCREENS; i++)
        *(dest++) = *(src++);
}

void vga_scroll_up(char *buffer)
{
    unsigned short *src = (unsigned short *)(buffer + 2 * TEXT_SCREENW);
    unsigned short *dest = (unsigned short *)buffer;
    char *p;
    int i;

    /* copy */
    for (i = 0; i < TEXT_SCREENW * (TEXT_SCREENH - 1); i++) {
        *(dest++) = *(src++);
    }

    /* clear the last line */
    p = (char *)(buffer + 2 * TEXT_SCREENW * (TEXT_SCREENH - 1));
    for (i = 0; i < TEXT_SCREENW; i++) {
        *(p++) = 0;
        *(p++) = DEFAULT_ATTR;
    }
}
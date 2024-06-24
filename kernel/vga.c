#include <vga.h>

/*
 * Here are some VGA text mode functions
 */

static char hex_digits[] = "0123456789ABCDEF";

void cls(char c, attr_t a)
{
	int i = 0;
	
	while (i < 2 * TEXT_SCREENS) {
		*((char *)(TEXT_MEM + i++)) = c;
		*((char *)(TEXT_MEM + i++)) = a;
	}
}

void putchar(int x, int y, char c, attr_t a)
{
	char *p = (char *)(TEXT_MEM + 2 * (TEXT_SCREENW * y + x));
	*p = c;
	*(p + 1) = a;
}

void print(int x, int y, char *s, attr_t a)
{
	char *p = (char *)(TEXT_MEM + 2 * (TEXT_SCREENW * y + x));
	while (*s) {
		*(p++) = *(s++);
		*(p++) = a;
	}
}

void print_hex(int x, int y, unsigned char n, attr_t a)
{
    char *p = (char *)(TEXT_MEM + 2 * (TEXT_SCREENW * y + x));
    *(p++) = hex_digits[n >> 4];
    *(p++) = a;
    *(p++) = hex_digits[n & 15];
    *(p++) = a;
}
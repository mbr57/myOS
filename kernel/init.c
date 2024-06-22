#define TEXT_MEM 0xb8000
#define SCREENW 80
#define SCREENH 25

void print(char *s, int x, int y, char c)
{
	short *p = (short *)(TEXT_MEM + 2 * (SCREENW * y + x));
	while (*s)
		*(p++) = c << 8 | *(s++);
}

void _start()
{
	print("Kernel has started.", 1, 1, 0x0a);
	while (1) ;
}

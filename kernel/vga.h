#ifndef _vga_h_
#define _vga_h_

#define TEXT_MEM 0xb8000
#define TEXT_SCREENW 80
#define TEXT_SCREENH 25
#define TEXT_SCREENS 80 * 25

/* VGA colors */
#define VGA_BLACK 0
#define VGA_BLUE 1
#define VGA_GREEN 2
#define VGA_CYAN 3
#define VGA_RED 4
#define VGA_MAGENTA 5
#define VGA_BROWN 6
#define VGA_GREY 7

#define VGA_LIGHT 8

typedef char attr_t;

void cls(char c, attr_t a);
void putchar(int x, int y, char c, attr_t a);
void print(int x, int y, char *s, attr_t a);

#endif
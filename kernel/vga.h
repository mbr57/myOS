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

#define DEFAULT_ATTR (VGA_BLUE << 4) | (VGA_GREY | VGA_LIGHT)

typedef char attr_t;

void vga_clear_screen(char *buffer, char c, attr_t a);

void vga_disable_cursor();
void vga_move_cursor(int x, int y);

void vga_putchar(char *buffer, int x, int y, char c, attr_t a);
void vga_print(char *buffer, int x, int y, char *s, attr_t a);
void vga_print_hex(char *buffer, int x, int y, unsigned char n, attr_t a);

void vga_copy(char *buffer);
void vga_scroll_up(char *buffer);

#endif
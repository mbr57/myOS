#include <tty.h>

struct tty_state tty[5];
int current_tty = 0;

void tty_init(int n)
{
    struct tty_state *t = &tty[n];
    unsigned char *p = (unsigned char *)t->buffer;
    int i;

    for (i = 0; i < TEXT_SCREENS; i++) {
        *(p++) = 0;
        *(p++) = DEFAULT_ATTR;
    }

    t->cursor_x = 0;
    t->cursor_y = 0;
}

void tty_switch(int n)
{
    struct tty_state *t = &tty[n];
    unsigned short *src = (unsigned short *)TEXT_MEM;
    unsigned short *dest = (unsigned short *)tty[current_tty].buffer;
    int i;
    
    /* save previous tty's buffer */
    for (i = 0; i < TEXT_SCREENS; i++)
        *(dest++) = *(src++);
        
    vga_copy(t->buffer);
    vga_move_cursor(t->cursor_x, t->cursor_y);
    current_tty = n;
}

void tty_putchar(int n, char c)
{
    struct tty_state *t = &tty[n];
    char *buffer;

    if (current_tty == n)
        buffer = TEXT_MEM;
    else
        buffer = t->buffer;

    if (c == '\n' || t->cursor_x >= TEXT_SCREENW) {
        t->cursor_x = 0;
        t->cursor_y++;
    } else {
        while (t->cursor_y >= TEXT_SCREENH) {
            vga_scroll_up(buffer);
            t->cursor_y--;
        }
        vga_putchar(buffer, t->cursor_x++, t->cursor_y, c, DEFAULT_ATTR);
    }

    if (current_tty == n)
        vga_move_cursor(t->cursor_x, t->cursor_y);
}

void tty_print(int n, char *s)
{
    while (*s) {
        tty_putchar(n, *s);
        s++;
    }
}
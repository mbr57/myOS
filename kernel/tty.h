#ifndef _tty_h_
#define _tty_h_

#include <vga.h>

#pragma pack(1)
struct tty_state
{
    char buffer[2 * TEXT_SCREENS];
    unsigned short cursor_x;
    unsigned short cursor_y;
};

void tty_init(int n);
void tty_switch(int n);
void tty_putchar(int n, char c);
void tty_print(int n, char *s);

#endif
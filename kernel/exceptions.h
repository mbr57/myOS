#ifndef _exceptions_h_
#define _exceptions_h_

/* this seems to be already packed */
struct idt_entry {
	unsigned short offset_low;
	unsigned short selector;
	unsigned char reserved;
	unsigned char attributes;
	unsigned short offset_high; 
};

void div0_handler();
void default_handler();

void set_exception_handler(int entry, void *handler, char attributes);

#endif
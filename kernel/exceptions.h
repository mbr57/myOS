#ifndef _exceptions_h_
#define _exceptions_h_

#pragma pack(1)
struct idt_entry {
	unsigned short offset_low;
	unsigned short selector;
	unsigned char reserved;
	unsigned char attributes;
	unsigned short offset_high; 
};

void div0_handler();
void default_handler();

void setup_idt();
void set_exception_handler(int entry, void *handler);

#endif
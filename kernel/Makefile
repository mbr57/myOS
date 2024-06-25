%.o: %.c
	smlrcc -Wall -c -I. $< -o $@
	
%.o: %.asm
	nasm -felf $< -o $@
	
%.bin: %.asm
	nasm -fbin $< -o $@
	
all: start.bin kstart.bin
	copy /b start.bin+kstart.bin kernel.bin

kstart.bin: init.o vga.o interrupts.o wrappers.o
	smlrcc -I. -flat32 -origin 0x4200 init.o vga.o interrupts.o wrappers.o -o kstart.bin
	
clean:
	del *.o
	del *.bin
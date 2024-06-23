%.o: %.c
	smlrcc -Wall -c -I. $< -o $@
	
%.bin: %.asm
	nasm -fbin $< -o $@
	
all: start.bin kstart.bin
	copy /b start.bin+kstart.bin kernel.bin

kstart.bin: init.o vga.o exceptions.o
	smlrcc -I. -flat32 -origin 0x1200 init.o vga.o exceptions.o -o kstart.bin
	
clean:
	del *.o
	del *.bin
%.bin: %.asm
	nasm -fbin $< -o $@

all: bootloader.bin

clean:
	del *.bin
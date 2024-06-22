all:
	cd boot && make
	cd kernel && make
	copy /b boot\bootloader.bin+kernel\kernel.bin os.bin
	
run:
	qemu-system-i386 os.bin
	
clean:
	cd boot && make clean
	cd kernel && make clean
	del *.bin
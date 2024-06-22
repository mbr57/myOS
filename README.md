# myOS
This is just a hobbyist IA-32 operating system that I am writing while learning OS development.
Contributions are welcome.

The bootloader loads the kernel and stores it in memory, from linear address 0x1000.
The first 512 bytes of the kernel (0x1000 - 0x1200 in memory) sets up protected mode
and segmentation (kernel\start.asm). Then it jumps to 0x1200 (kernel\init.c).
The kernel will then display a message on the screen.

# Tools
- assembler: nasm
- C compiler: Smaller C compiler
- emulator: qemu-system-i386

# Building
- In 'boot':
  - Assemble the bootloader: `nasm -fbin bootloader.asm -o bootloader.bin`
- In 'kernel':
  - Assemble start.asm: `nasm -fbin start.asm -o start.bin`
  - Compile init.c: `smlrcc -flat32 -origin 0x1200 init.c -o init.bin`
  - Concatenate the binary files: `copy /b start.bin+init.bin kernel.bin`
- In root repository directory:
  - Concatenate the bootloader and kernel.bin: `copy /b boot\bootloader.bin+kernel\kernel.bin os.bin`

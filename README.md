# myOS
This is just a hobbyist IA-32 operating system that I am writing while learning OS development.
Contributions are welcome.

The bootloader loads the kernel and stores it in memory, from linear address 0x4000.
The first 512 bytes of the kernel (0x4000 - 0x4200 in memory) sets up protected mode, segmentation and paging (kernel\start.asm). Then it jumps to 0x4200 (kernel\init.c).
The kernel will then display things on the screen.

# Tools
- assembler: nasm
- C compiler: Smaller C compiler
- emulator: qemu-system-i386
- GNUWin32 make

	[bits 16]
	[org 0x1000]
	
PIC1 equ 0x20
PIC2 equ 0xa0

; wait for a short delay (it may be required to wait for the PIC)
%macro iowait 0
	jmp $ + 2
	jmp $ + 2
%endmacro
	
start:
	; assuming that A20 line is enabled
	; enter in protected mode
	cli               ; disable interrupts
	lgdt [gdt_desc]   ; load the GDT
	lidt [idt_desc]   ; load the IDT
	mov eax, cr0
	or eax, 1         ; set protected mode
	mov cr0, eax
	jmp 8:pmode_start     ; this loads cs with correct descriptor offset 
	                      ; and clears the prefetch queue
	
	[bits 32]
	
pmode_start:
	mov ax, 0x10      ; offset of data descriptor
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov esp, 0x9000
	
	; now, remap the PIC
	; map master PIC's vector offsets to 0x20 - 0x27
	; and slave PIC's vector offsets to 0x28 - 0x2f
	; so that they don't collapse with CPU exceptions
	
	; init sequence
	mov al, 0x11
	out PIC1, al
	iowait
	out PIC2, al
	iowait
	; remap master PIC
	mov al, 0x20
	out PIC1 + 1, al
	iowait
	; remap slave PIC
	mov al, 0x28
	out PIC2 + 1, al
	iowait
	; slave PIC at IRQ2
	mov al, 4
	out PIC1 + 1, al
	iowait
	mov al, 2
	out PIC2 + 1, al
	iowait
	; set 8086 mode
	mov al, 1
	out PIC1 + 1, al
	iowait
	out PIC2 + 1, al
	iowait
	; disable all interrupts
	mov al, 0xff
	out PIC1 + 1, al
	iowait
	out PIC2 + 1, al
	iowait
	
	jmp 8:0x1200      ; jump to the kernel (init.s)
	
gdt:
	dd 0,0		; null segment
code_seg:       ; 0x100000 * 4 KiB = 4 MiB, starts at address 0
	dw 0xffff
	dw 0
	db 0
	db 0b10011010
	db 0b11001111
	db 0
data_seg:       ; 0x100000 * 4 KiB = 4 MiB, starts at address 0
	dw 0xffff
	dw 0
	db 0
	db 0b10010010
	db 0b11001111
	db 0
gdt_end:

gdt_desc:
	dw gdt_end - gdt - 1   ; gdt size
	dd gdt                 ; gdt pointer
	
idt_desc:
	dw 256 * 8
	dd 0
	
padding:
	times 512 - ($ - $$) db 0
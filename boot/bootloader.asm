	[bits 16]
	[org 0x7c00]
	
start:
	; set up registers
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x9000
	
	; clear the screen
	mov ax, 3 ; set video mode
	int 0x10
	
	; load the kernel into 0x4000
	mov ah, 0x42	; extended read
	mov si, dap
	int 0x13
	
	; jump to the kernel
	jmp 0x4000
	
dap:
	db 0x10       ; DAP size
	db 0
	dw 25         ; number of sectors to read
	dw 0x4000     ; offset
	dw 0          ; segment
	dq 1          ; LBA address (2nd sector)
	
padding:
	times 510 - ($ - $$) db 0
mbr_signature:
	db 0x55, 0xAA
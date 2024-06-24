bits 32

; glb div0_handler : () void
; glb keyboard_handler : () void
; glb default_handler : () void
; glb setup_idt : () void
; glb set_idt_attributes : (
; prm     entry : int
; prm     attributes : unsigned char
;     ) void
; glb set_handler : (
; prm     entry : int
; prm     handler : * void
;     ) void
; glb attr_t : char
; glb cls : (
; prm     c : char
; prm     a : char
;     ) void
; glb putchar : (
; prm     x : int
; prm     y : int
; prm     c : char
; prm     a : char
;     ) void
; glb print : (
; prm     x : int
; prm     y : int
; prm     s : * char
; prm     a : char
;     ) void
; glb print_hex : (
; prm     x : int
; prm     y : int
; prm     n : unsigned char
; prm     a : char
;     ) void
; glb pic1_m : char
section .bss
	global	_pic1_m
_pic1_m:
	resb	1

; glb pic2_m : char
section .bss
	global	_pic2_m
_pic2_m:
	resb	1

; glb _start : () void
section .text
	global	__start
__start:
	push	ebp
	mov	ebp, esp
	;mov	eax,          4
	;call	L1
	 sub	esp,          4
; loc     i : (@-4) : int
mov dx, 0x3d4
mov al, 0x0a
out dx, al
mov al, 0x20
inc dx
out dx, al

; RPN'ized expression: "( 1 4 << , 0 cls ) "
; Expanded expression: " 16  0  cls ()8 "
; Fused expression:    "( 16 , 0 , cls )8 "
	push	16
	push	0
	call	_cls
	sub	esp, -8

section .rodata
L4:
	db	"Kernel has started."
	times	1 db 0

section .text
; RPN'ized expression: "( 1 4 << 7 8 | | , L4 , 1 , 1 print ) "
; Expanded expression: " 31  L4  1  1  print ()16 "
; Fused expression:    "( 31 , L4 , 1 , 1 , print )16 "
	push	31
	push	L4
	push	1
	push	1
	call	_print
	sub	esp, -16
; RPN'ized expression: "( div0_handler , 0 set_handler ) "
; Expanded expression: " div0_handler  0  set_handler ()8 "
; Fused expression:    "( div0_handler , 0 , set_handler )8 "
	push	_div0_handler
	push	0
	call	_set_handler
	sub	esp, -8
; for
; RPN'ized expression: "i 1 = "
; Expanded expression: "(@-4) 1 =(4) "
; Fused expression:    "=(204) *(@-4) 1 "
	mov	eax, 1
	mov	[ebp-4], eax
L5:
; RPN'ized expression: "i 256 < "
; Expanded expression: "(@-4) *(4) 256 < "
; Fused expression:    "< *(@-4) 256 IF! "
	mov	eax, [ebp-4]
	cmp	eax, 256
	jge	L8
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-4) ++p(4) "
; {
; RPN'ized expression: "( default_handler , i set_handler ) "
; Expanded expression: " default_handler  (@-4) *(4)  set_handler ()8 "
; Fused expression:    "( default_handler , *(4) (@-4) , set_handler )8 "
	push	_default_handler
	push	dword [ebp-4]
	call	_set_handler
	sub	esp, -8
; }
L6:
; Fused expression:    "++p(4) *(@-4) "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	jmp	L5
L8:
; RPN'ized expression: "( keyboard_handler , 33 set_handler ) "
; Expanded expression: " keyboard_handler  33  set_handler ()8 "
; Fused expression:    "( keyboard_handler , 33 , set_handler )8 "
	push	_keyboard_handler
	push	33
	call	_set_handler
	sub	esp, -8
; RPN'ized expression: "( setup_idt ) "
; Expanded expression: " setup_idt ()0 "
; Fused expression:    "( setup_idt )0 "
	call	_setup_idt
; RPN'ized expression: "( 142 , 33 set_idt_attributes ) "
; Expanded expression: " 142  33  set_idt_attributes ()8 "
; Fused expression:    "( 142 , 33 , set_idt_attributes )8 "
	push	142
	push	33
	call	_set_idt_attributes
	sub	esp, -8
in al, 0x21
mov _pic1_m, al
in al, 0xa1
mov _pic2_m, al

; RPN'ized expression: "( 1 4 << 7 | , 254 , 9 , 9 print_hex ) "
; Expanded expression: " 23  254  9  9  print_hex ()16 "
; Fused expression:    "( 23 , 254 , 9 , 9 , print_hex )16 "
	push	23
	push	254
	push	9
	push	9
	call	_print_hex
	sub	esp, -16
; RPN'ized expression: "i i 0 / = "
; Expanded expression: "(@-4) (@-4) *(4) 0 / =(4) "
; Fused expression:    "/ *(@-4) 0 =(204) *(@-4) ax "
	mov	eax, [ebp-4]
	cdq
	mov	ecx, 0
	idiv	ecx
	mov	[ebp-4], eax
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L9:
	jmp	L9
L10:
L2:
	leave
	ret


	extern	_cls
	extern	_print
	extern	_div0_handler
	extern	_set_handler
	extern	_default_handler
	extern	_keyboard_handler
	extern	_setup_idt
	extern	_set_idt_attributes
	extern	_print_hex

; Syntax/declaration table/stack:
; Bytes used: 610/15360


; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_32__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Macro __SMALLER_C_UWCHAR__ = ``
; Macro __SMALLER_C_WCHAR16__ = ``
; Bytes used: 110/5120


; Identifier table:
; Ident 
; Ident __floatsisf
; Ident __floatunsisf
; Ident __fixsfsi
; Ident __fixunssfsi
; Ident __addsf3
; Ident __subsf3
; Ident __negsf2
; Ident __mulsf3
; Ident __divsf3
; Ident __lesf2
; Ident __gesf2
; Ident idt_entry
; Ident offset_low
; Ident selector
; Ident reserved
; Ident attributes
; Ident offset_high
; Ident <something>
; Ident div0_handler
; Ident keyboard_handler
; Ident default_handler
; Ident setup_idt
; Ident set_idt_attributes
; Ident entry
; Ident set_handler
; Ident handler
; Ident attr_t
; Ident cls
; Ident c
; Ident a
; Ident putchar
; Ident x
; Ident y
; Ident print
; Ident s
; Ident print_hex
; Ident n
; Ident pic1_m
; Ident pic2_m
; Ident _start
; Bytes used: 395/5632

; Next label number: 11
; Compilation succeeded.

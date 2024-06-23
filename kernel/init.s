bits 32

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
; glb int0_handler : () void
section .text
	global	_int0_handler
_int0_handler:
	push	ebp
	mov	ebp, esp
	;mov	eax,          0
	;call	L1
	;sub	esp,          0

section .rodata
L4:
	db	"Division by 0"
	times	1 db 0

section .text
; RPN'ized expression: "( 1 4 << 4 8 | | , L4 , 3 , 2 print ) "
; Expanded expression: " 28  L4  3  2  print ()16 "
; Fused expression:    "( 28 , L4 , 3 , 2 , print )16 "
	push	28
	push	L4
	push	3
	push	2
	call	_print
	sub	esp, -16
L2:
	leave
	ret

; glb _start : () void
section .text
	global	__start
__start:
	push	ebp
	mov	ebp, esp
	;mov	eax,         12
	;call	L1
	 sub	esp,         12
; loc     a : (@-4) : int
; RPN'ized expression: "a 6 = "
; Expanded expression: "(@-4) 6 =(4) "
; Fused expression:    "=(204) *(@-4) 6 "
	mov	eax, 6
	mov	[ebp-4], eax
; loc     int0 : (@-8) : * struct idt_entry
; loc     <something> : * struct idt_entry
; RPN'ized expression: "int0 0 (something7) = "
; Expanded expression: "(@-8) 0 =(4) "
; Fused expression:    "=(204) *(@-8) 0 "
	mov	eax, 0
	mov	[ebp-8], eax
; loc     p : (@-12) : * void
; RPN'ized expression: "p int0_handler = "
; Expanded expression: "(@-12) int0_handler =(4) "
; Fused expression:    "=(204) *(@-12) int0_handler "
	mov	eax, _int0_handler
	mov	[ebp-12], eax
; loc     <something> : unsigned short
; RPN'ized expression: "int0 offset_low -> *u p (something8) 65535 & = "
; Expanded expression: "(@-8) *(4) 0 + (@-12) *(4) unsigned short 65535 & =(2) "
; Fused expression:    "+ *(@-8) 0 push-ax *(4) (@-12) unsigned short & ax 65535 =(172) **sp ax "
	mov	eax, [ebp-8]
	push	eax
	mov	eax, [ebp-12]
	movzx	eax, ax
	and	eax, 65535
	pop	ebx
	mov	[ebx], ax
	movzx	eax, ax
; RPN'ized expression: "int0 selector -> *u 8 = "
; Expanded expression: "(@-8) *(4) 2 + 8 =(2) "
; Fused expression:    "+ *(@-8) 2 =(172) *ax 8 "
	mov	eax, [ebp-8]
	add	eax, 2
	mov	ebx, eax
	mov	eax, 8
	mov	[ebx], ax
	movzx	eax, ax
; RPN'ized expression: "int0 reserved -> *u 0 = "
; Expanded expression: "(@-8) *(4) 4 + 0 =(1) "
; Fused expression:    "+ *(@-8) 4 =(156) *ax 0 "
	mov	eax, [ebp-8]
	add	eax, 4
	mov	ebx, eax
	mov	eax, 0
	mov	[ebx], al
	movzx	eax, al
; RPN'ized expression: "int0 attributes -> *u 143 = "
; Expanded expression: "(@-8) *(4) 5 + 143 =(1) "
; Fused expression:    "+ *(@-8) 5 =(156) *ax 143 "
	mov	eax, [ebp-8]
	add	eax, 5
	mov	ebx, eax
	mov	eax, 143
	mov	[ebx], al
	movzx	eax, al
; loc     <something> : unsigned short
; RPN'ized expression: "int0 offset_high -> *u p (something9) 16 >> = "
; Expanded expression: "(@-8) *(4) 6 + (@-12) *(4) unsigned short 16 >> =(2) "
; Fused expression:    "+ *(@-8) 6 push-ax *(4) (@-12) unsigned short >> ax 16 =(172) **sp ax "
	mov	eax, [ebp-8]
	add	eax, 6
	push	eax
	mov	eax, [ebp-12]
	movzx	eax, ax
	sar	eax, 16
	pop	ebx
	mov	[ebx], ax
	movzx	eax, ax
; RPN'ized expression: "( 1 4 << , 0 cls ) "
; Expanded expression: " 16  0  cls ()8 "
; Fused expression:    "( 16 , 0 , cls )8 "
	push	16
	push	0
	call	_cls
	sub	esp, -8

section .rodata
L10:
	db	"Kernel has started."
	times	1 db 0

section .text
; RPN'ized expression: "( 1 4 << 7 8 | | , L10 , 1 , 1 print ) "
; Expanded expression: " 31  L10  1  1  print ()16 "
; Fused expression:    "( 31 , L10 , 1 , 1 , print )16 "
	push	31
	push	L10
	push	1
	push	1
	call	_print
	sub	esp, -16
; RPN'ized expression: "a a 0 / = "
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
L11:
	jmp	L11
L12:
L5:
	leave
	ret


	extern	_print
	extern	_cls

; Syntax/declaration table/stack:
; Bytes used: 385/15360


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
; Ident attr_t
; Ident cls
; Ident c
; Ident a
; Ident putchar
; Ident x
; Ident y
; Ident print
; Ident s
; Ident idt_entry
; Ident offset_low
; Ident selector
; Ident reserved
; Ident attributes
; Ident offset_high
; Ident <something>
; Ident int0_handler
; Ident _start
; Bytes used: 270/5632

; Next label number: 13
; Compilation succeeded.

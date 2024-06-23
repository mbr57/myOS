bits 32

; glb div0_handler : () void
; glb default_handler : () void
; glb setup_idt : () void
; glb set_exception_handler : (
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
; RPN'ized expression: "32 "
; Expanded expression: "32 "
; Expression value: 32
; glb handlers : [32u] unsigned
section .bss
	alignb 4
	global	$handlers
$handlers:
	resb	128

; glb div0_handler : () void
section .text
	global	$div0_handler
$div0_handler:
	push	ebp
	mov	ebp, esp
	;sub	esp,          0

section .rodata
..@L3:
	db	"Division by 0"
	times	1 db 0

section .text
; RPN'ized expression: "( 1 4 << 4 8 | | , L3 , 3 , 3 print ) "
; Expanded expression: " 28  L3  3  3  print ()16 "
; Fused expression:    "( 28 , L3 , 3 , 3 , print )16 "
	push	28
	push	..@L3
	push	3
	push	3
	call	$print
	sub	esp, -16
..@L1:
	leave
	ret

; glb default_handler : () void
section .text
	global	$default_handler
$default_handler:
	push	ebp
	mov	ebp, esp
	;sub	esp,          0

section .rodata
..@L6:
	db	"Default exception handler"
	times	1 db 0

section .text
; RPN'ized expression: "( 1 4 << 4 8 | | , L6 , 3 , 3 print ) "
; Expanded expression: " 28  L6  3  3  print ()16 "
; Fused expression:    "( 28 , L6 , 3 , 3 , print )16 "
	push	28
	push	..@L6
	push	3
	push	3
	call	$print
	sub	esp, -16
..@L4:
	leave
	ret

; glb setup_idt : () void
section .text
	global	$setup_idt
$setup_idt:
	push	ebp
	mov	ebp, esp
	 sub	esp,          8
; loc     p : (@-4) : * struct idt_entry
; loc     <something> : * struct idt_entry
; RPN'ized expression: "p 0 (something9) = "
; Expanded expression: "(@-4) 0 =(4) "
; Fused expression:    "=(204) *(@-4) 0 "
	mov	eax, 0
	mov	[ebp-4], eax
; loc     i : (@-8) : int
..@L7:
	leave
	ret

; glb set_exception_handler : (
; prm     entry : int
; prm     handler : * void
;     ) void
section .text
	global	$set_exception_handler
$set_exception_handler:
	push	ebp
	mov	ebp, esp
	;sub	esp,          0
; loc     entry : (@8) : int
; loc     handler : (@12) : * void
; loc     <something> : unsigned
; RPN'ized expression: "handlers entry + *u handler (something12) = "
; Expanded expression: "handlers (@8) *(4) 4 * + (@12) *(4) =(4) "
; Fused expression:    "* *(@8) 4 + handlers ax =(204) *ax *(@12) "
	mov	eax, [ebp+8]
	imul	eax, eax, 4
	mov	ecx, eax
	mov	eax, $handlers
	add	eax, ecx
	mov	ebx, eax
	mov	eax, [ebp+12]
	mov	[ebx], eax
..@L10:
	leave
	ret


	extern	$print

; Syntax/declaration table/stack:
; Bytes used: 580/15360


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
; Ident default_handler
; Ident setup_idt
; Ident set_exception_handler
; Ident entry
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
; Ident handlers
; Bytes used: 339/5632

; Next label number: 13
; Compilation succeeded.

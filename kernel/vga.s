bits 32

; glb attr_t : char
; glb cls : (
; prm     c : char
; prm     a : char
;     ) void
; glb disable_cursor : () void
; glb move_cursor : (
; prm     x : int
; prm     y : int
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
; glb hex_digits : [0u] char
section .data
_hex_digits:
; =
	db	"0123456789ABCDEF"
	times	1 db 0

; glb cls : (
; prm     c : char
; prm     a : char
;     ) void
section .text
	global	_cls
_cls:
	push	ebp
	mov	ebp, esp
	;mov	eax,          4
	;call	L1
	 sub	esp,          4
; loc     c : (@8) : char
; loc     a : (@12) : char
; loc     i : (@-4) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-4) 0 =(4) "
; Fused expression:    "=(204) *(@-4) 0 "
	mov	eax, 0
	mov	[ebp-4], eax
; while
; RPN'ized expression: "i 2 80 * 25 * < "
; Expanded expression: "(@-4) *(4) 4000 < "
L4:
; Fused expression:    "< *(@-4) 4000 IF! "
	mov	eax, [ebp-4]
	cmp	eax, 4000
	jge	L5
; {
; loc         <something> : * char
; RPN'ized expression: "753664 i ++p + (something6) *u c = "
; Expanded expression: "753664 (@-4) ++p(4) + (@8) *(-1) =(-1) "
; Fused expression:    "++p(4) *(@-4) + 753664 ax =(119) *ax *(@8) "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	mov	ecx, eax
	mov	eax, 753664
	add	eax, ecx
	mov	ebx, eax
	mov	al, [ebp+8]
	movsx	eax, al
	mov	[ebx], al
	movsx	eax, al
; loc         <something> : * char
; RPN'ized expression: "753664 i ++p + (something7) *u a = "
; Expanded expression: "753664 (@-4) ++p(4) + (@12) *(-1) =(-1) "
; Fused expression:    "++p(4) *(@-4) + 753664 ax =(119) *ax *(@12) "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	mov	ecx, eax
	mov	eax, 753664
	add	eax, ecx
	mov	ebx, eax
	mov	al, [ebp+12]
	movsx	eax, al
	mov	[ebx], al
	movsx	eax, al
; }
	jmp	L4
L5:
L2:
	leave
	ret

; glb disable_cursor : () void
section .text
	global	_disable_cursor
_disable_cursor:
	push	ebp
	mov	ebp, esp
	;mov	eax,          0
	;call	L1
	;sub	esp,          0
mov dx, 0x3d4
mov al, 0x0a
out dx, al
mov al, 0x20
inc dx
out dx, al

L8:
	leave
	ret

; glb move_cursor : (
; prm     x : int
; prm     y : int
;     ) void
section .text
	global	_move_cursor
_move_cursor:
	push	ebp
	mov	ebp, esp
	;mov	eax,          4
	;call	L1
	 sub	esp,          4
; loc     x : (@8) : int
; loc     y : (@12) : int
; loc     pos : (@-4) : unsigned short
; RPN'ized expression: "pos 80 y * x + = "
; Expanded expression: "(@-4) 80 (@12) *(4) * (@8) *(4) + =(2) "
; Fused expression:    "* 80 *(@12) + ax *(@8) =(204) *(@-4) ax "
	mov	eax, 80
	mul	dword [ebp+12]
	add	eax, [ebp+8]
	mov	[ebp-4], eax
mov bx, word [_pos]
mov dx, 0x3d4
mov al, 0x0f
out dx, al
inc dx
mov al, bl
out dx, al
dec dx
mov al, 0x0e
out dx, al
inc dx
mov al, bh
out dx, al
L10:
	leave
	ret

; glb putchar : (
; prm     x : int
; prm     y : int
; prm     c : char
; prm     a : char
;     ) void
section .text
	global	_putchar
_putchar:
	push	ebp
	mov	ebp, esp
	;mov	eax,          4
	;call	L1
	 sub	esp,          4
; loc     x : (@8) : int
; loc     y : (@12) : int
; loc     c : (@16) : char
; loc     a : (@20) : char
; loc     p : (@-4) : * char
; loc     <something> : * char
; RPN'ized expression: "p 753664 2 80 y * x + * + (something14) = "
; Expanded expression: "(@-4) 753664 2 80 (@12) *(4) * (@8) *(4) + * + =(4) "
; Fused expression:    "* 80 *(@12) + ax *(@8) * 2 ax + 753664 ax =(204) *(@-4) ax "
	mov	eax, 80
	mul	dword [ebp+12]
	add	eax, [ebp+8]
	mov	ecx, eax
	mov	eax, 2
	mul	ecx
	mov	ecx, eax
	mov	eax, 753664
	add	eax, ecx
	mov	[ebp-4], eax
; RPN'ized expression: "p *u c = "
; Expanded expression: "(@-4) *(4) (@16) *(-1) =(-1) "
; Fused expression:    "*(4) (@-4) =(119) *ax *(@16) "
	mov	eax, [ebp-4]
	mov	ebx, eax
	mov	al, [ebp+16]
	movsx	eax, al
	mov	[ebx], al
	movsx	eax, al
; RPN'ized expression: "p 1 + *u a = "
; Expanded expression: "(@-4) *(4) 1 + (@20) *(-1) =(-1) "
; Fused expression:    "+ *(@-4) 1 =(119) *ax *(@20) "
	mov	eax, [ebp-4]
	inc	eax
	mov	ebx, eax
	mov	al, [ebp+20]
	movsx	eax, al
	mov	[ebx], al
	movsx	eax, al
L12:
	leave
	ret

; glb print : (
; prm     x : int
; prm     y : int
; prm     s : * char
; prm     a : char
;     ) void
section .text
	global	_print
_print:
	push	ebp
	mov	ebp, esp
	;mov	eax,          4
	;call	L1
	 sub	esp,          4
; loc     x : (@8) : int
; loc     y : (@12) : int
; loc     s : (@16) : * char
; loc     a : (@20) : char
; loc     p : (@-4) : * char
; loc     <something> : * char
; RPN'ized expression: "p 753664 2 80 y * x + * + (something17) = "
; Expanded expression: "(@-4) 753664 2 80 (@12) *(4) * (@8) *(4) + * + =(4) "
; Fused expression:    "* 80 *(@12) + ax *(@8) * 2 ax + 753664 ax =(204) *(@-4) ax "
	mov	eax, 80
	mul	dword [ebp+12]
	add	eax, [ebp+8]
	mov	ecx, eax
	mov	eax, 2
	mul	ecx
	mov	ecx, eax
	mov	eax, 753664
	add	eax, ecx
	mov	[ebp-4], eax
; while
; RPN'ized expression: "s *u "
; Expanded expression: "(@16) *(4) *(-1) "
L18:
; Fused expression:    "*(4) (@16) *(-1) ax  "
	mov	eax, [ebp+16]
	mov	ebx, eax
	mov	al, [ebx]
	movsx	eax, al
; JumpIfZero
	test	eax, eax
	je	L19
; {
; RPN'ized expression: "p ++p *u s ++p *u = "
; Expanded expression: "(@-4) ++p(4) (@16) ++p(4) *(-1) =(-1) "
; Fused expression:    "++p(4) *(@-4) push-ax ++p(4) *(@16) =(119) **sp *ax "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	push	eax
	mov	eax, [ebp+16]
	inc	dword [ebp+16]
	mov	ebx, eax
	mov	al, [ebx]
	movsx	eax, al
	pop	ebx
	mov	[ebx], al
	movsx	eax, al
; RPN'ized expression: "p ++p *u a = "
; Expanded expression: "(@-4) ++p(4) (@20) *(-1) =(-1) "
; Fused expression:    "++p(4) *(@-4) =(119) *ax *(@20) "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	mov	ebx, eax
	mov	al, [ebp+20]
	movsx	eax, al
	mov	[ebx], al
	movsx	eax, al
; }
	jmp	L18
L19:
L15:
	leave
	ret

; glb print_hex : (
; prm     x : int
; prm     y : int
; prm     n : unsigned char
; prm     a : char
;     ) void
section .text
	global	_print_hex
_print_hex:
	push	ebp
	mov	ebp, esp
	;mov	eax,          4
	;call	L1
	 sub	esp,          4
; loc     x : (@8) : int
; loc     y : (@12) : int
; loc     n : (@16) : unsigned char
; loc     a : (@20) : char
; loc     p : (@-4) : * char
; loc     <something> : * char
; RPN'ized expression: "p 753664 2 80 y * x + * + (something22) = "
; Expanded expression: "(@-4) 753664 2 80 (@12) *(4) * (@8) *(4) + * + =(4) "
; Fused expression:    "* 80 *(@12) + ax *(@8) * 2 ax + 753664 ax =(204) *(@-4) ax "
	mov	eax, 80
	mul	dword [ebp+12]
	add	eax, [ebp+8]
	mov	ecx, eax
	mov	eax, 2
	mul	ecx
	mov	ecx, eax
	mov	eax, 753664
	add	eax, ecx
	mov	[ebp-4], eax
; RPN'ized expression: "p ++p *u hex_digits n 4 >> + *u = "
; Expanded expression: "(@-4) ++p(4) hex_digits (@16) *(1) 4 >> + *(-1) =(-1) "
; Fused expression:    "++p(4) *(@-4) push-ax >> *(@16) 4 + hex_digits ax =(119) **sp *ax "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	push	eax
	mov	al, [ebp+16]
	movzx	eax, al
	sar	eax, 4
	mov	ecx, eax
	mov	eax, _hex_digits
	add	eax, ecx
	mov	ebx, eax
	mov	al, [ebx]
	movsx	eax, al
	pop	ebx
	mov	[ebx], al
	movsx	eax, al
; RPN'ized expression: "p ++p *u a = "
; Expanded expression: "(@-4) ++p(4) (@20) *(-1) =(-1) "
; Fused expression:    "++p(4) *(@-4) =(119) *ax *(@20) "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	mov	ebx, eax
	mov	al, [ebp+20]
	movsx	eax, al
	mov	[ebx], al
	movsx	eax, al
; RPN'ized expression: "p ++p *u hex_digits n 15 & + *u = "
; Expanded expression: "(@-4) ++p(4) hex_digits (@16) *(1) 15 & + *(-1) =(-1) "
; Fused expression:    "++p(4) *(@-4) push-ax & *(@16) 15 + hex_digits ax =(119) **sp *ax "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	push	eax
	mov	al, [ebp+16]
	movzx	eax, al
	and	eax, 15
	mov	ecx, eax
	mov	eax, _hex_digits
	add	eax, ecx
	mov	ebx, eax
	mov	al, [ebx]
	movsx	eax, al
	pop	ebx
	mov	[ebx], al
	movsx	eax, al
; RPN'ized expression: "p ++p *u a = "
; Expanded expression: "(@-4) ++p(4) (@20) *(-1) =(-1) "
; Fused expression:    "++p(4) *(@-4) =(119) *ax *(@20) "
	mov	eax, [ebp-4]
	inc	dword [ebp-4]
	mov	ebx, eax
	mov	al, [ebp+20]
	movsx	eax, al
	mov	[ebx], al
	movsx	eax, al
L20:
	leave
	ret



; Syntax/declaration table/stack:
; Bytes used: 660/15360


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
; Ident disable_cursor
; Ident move_cursor
; Ident x
; Ident y
; Ident putchar
; Ident print
; Ident s
; Ident print_hex
; Ident n
; Ident hex_digits
; Bytes used: 222/5632

; Next label number: 23
; Compilation succeeded.

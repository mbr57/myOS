	bits 32
	section .text
%assign i 0
%rep 32
	global _wrapper_handler_%+i
%assign i i+1
%endrep
	global _set_up_wrappers_table
	extern _handlers
	extern _wrappers
	
%macro WRAPPER 1
_wrapper_handler_%+%1:
	pusha
	mov esi, _handlers
	add esi, %1 << 2
	call [esi]
	popa
	iret
%endmacro

%assign i 0
%rep 32
WRAPPER i
%assign i i+1
%endrep

_set_up_wrappers_table:
	pusha
	mov esi, _wrappers
%assign i 0
%rep 32
	mov dword [esi], _wrapper_handler_%+i
	add esi, 4
%assign i i+1
%endrep
	popa
	ret
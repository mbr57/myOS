	bits 32
	section .text
%assign i 0
%rep 256
	global _wrapper_handler_%+i
%assign i i+1
%endrep
	global _set_up_wrappers_table
	extern _handlers
	extern _wrappers

%macro iowait 0
	jmp $ + 2
	jmp $ + 2
%endmacro

; send an end of interrupt to the PIC(s)
%macro SEND_EOI 1
  mov al, 0x20
%if %1 > 0x28
  out 0xa0, al
  iowait 
%endif
  out 0x20, al
  iowait
%endmacro

; first argument: handler number
; second argument: is for IRQ (1: yes, 0: no)
%macro WRAPPER 2
_wrapper_handler_%+%1:
	pusha
	call [_handlers + (%1 * 4)]
%if %2 = 1
  SEND_EOI %1
%endif
	popa
	iret
%endmacro

; for exceptions
%assign i 0
%rep 32
WRAPPER i, 0
%assign i i+1
%endrep

; for IRQs
%rep 16
WRAPPER i, 1
%assign i i+1
%endrep

%rep 256-32-16
WRAPPER i, 0
%assign i i+1
%endrep

_set_up_wrappers_table:
	pusha
	mov esi, _wrappers
%assign i 0
%rep 256
	mov dword [esi], _wrapper_handler_%+i
	add esi, 4
%assign i i+1
%endrep
	popa
	ret
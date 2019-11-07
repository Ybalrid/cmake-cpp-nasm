section .text				;"text" is code
bits 64						;64bit mode

global asm_foo				;globally exported location
asm_foo:					;function label
	mov rax, 1337			;Set return value
	ret						;Return from subroutine
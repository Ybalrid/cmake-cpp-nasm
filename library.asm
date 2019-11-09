;This can be assembled with NASM, maybe YASM
section .text
bits 64
;See library.hpp and main.cpp for "how to call these functions" from C++ code

;Exported symbols for the resuting object file. These are then just labels below
global asm_is_windows, compute_answer, sum_4_ints, increment_pointer_int64


;This function return true if the WIN32 macro was forwarded properly from CMake
; The top-level cmake file of this project will define WIN32 if Windows was detected as a platform
; We can use this for doing conditional assembly to deal with different ABIs
;
;		bool asm_is_windows()
asm_is_windows:
%ifdef WIN32
	mov rax, 1		; return bool(true)
%else
	xor rax, rax	; return bool(false)
%endif
	ret

;This is just a function that return the number 42
;Return values are "whatever is in RAX" in x64
;
;		int compute_answer()
compute_answer:
	mov rax, 101010b
	ret

;The 4 first arguments are passed on by registers
;The registers used for this purpose on WIN32 are
; RCX - 1st arg
; RDX - 2nd arg
; R8  - 3rd arg
; R9  - 4th arg
;And on other oses are
; RDI - 1st arg
; RSI - 2nd arg
; RCX - 3rd arg
; RDX - 4th arg
;
;		int sum_4_ints(int, int, int, int)
sum_4_ints:
%ifdef WIN32
	mov rax, rcx
	add rax, rdx
	add rax, r8
	add rax, r9
%else
	mov rax, rdi
	add rax, rsi
	add rax, rdx
	add rax, rcx
%endif
	ret

;pointers are naturally passed as arguments in the same way;
;the following procedure act as the following C code would do
;
;		void increment_pointer_int(int64_t* pointer) { *pointer++; }
increment_pointer_int64:
%ifdef WIN32
	add QWORD [rcx], 1		;QWORD [address] means that we are accessing a 64bit value
%else
	add QWORD [rdi], 1
%endif
	ret

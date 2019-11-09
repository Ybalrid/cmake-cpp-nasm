section .text
bits 64
;See func.asm.hpp and main.cpp for "how to call these functions" from C++ code


global asm_is_windows
asm_is_windows
%ifdef WIN32
mov rax, 1
%else
xor rax, rax
%endif
ret

;This is just a function that return the number 42
;Return values are "whatever is in RAX" in x64
global compute_answer
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
global sum_4_ints
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
;void increment_pointer_int(int64_t* pointer) { *pointer++; }
global increment_pointer_int64
increment_pointer_int64:
%ifdef WIN32
add QWORD [rcx], 1		;DWORD  [address] means that we are accessing a 32bit value
%else
add QWORD [rdi], 1
%endif
ret



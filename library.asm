section .text
bits 64
;See func.asm.hpp and main.cpp for "how to call these functions" from C++ code


;This is just a function that return the number 42
;Return values are "whatever is in RAX" in x64
global compute_answer
compute_answer:
mov rax, 101010b
ret

;The 4 first arguments are passed on by registers
;The registers used for this purpose are
; RCX - 1st arg
; RDX - 2nd arg
; R8  - 3rd arg
; R9  - 4th arg
global sum_4_ints
sum_4_ints:
mov rax, rcx
add rax, rdx
add rax, r8
add rax, r9
ret

;subsequent arguments are pushed on the stack.
;however, there's also the return address and 4 "shadow" 64bit values
;that correspond to the space the 4 first args would have occupied
;If you do the maths, this means that 5th argument is 40 bytes up the sack,
;and 6th is 48 bytes up the stack, etc...
global sum_6_ints
sum_6_ints:
mov rax, rcx
add rax, rdx
add rax, r8
add rax, r9
add rax, QWORD  [rsp + 40]
add rax, QWORD  [rsp + 48]
ret

;pointers are naturally passed as arguments in the same way;
;the following procedure act as the following C code would do
; int increment_pointer_int(int* pointer) { *pointer++; }
global increment_pointer_int
increment_pointer_int:
add DWORD  [rcx], 1		;DWORD  [address] means that we are accessing a 32bit value
ret


;the following procedure allocate local variables on the stack
;this is not the most efficient way to do so here. This is for
;illustration only
global swap
swap:
push rsp
sub rsp, 4 ;We only have *one* variable, in general we would have one regiser acting as a base pointer
mov eax, DWORD [rcx]
mov DWORD [rsp], eax
mov eax, DWORD [rdx]
mov DWORD [rcx], eax
mov eax, DWORD [rsp]
mov DWORD [rdx], eax
add rsp, 4
pop rsp
ret


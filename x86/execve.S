.intel_syntax noprefix
.globl _start
_start:
    jmp loadstring
execve:
    pop ebx
    xor eax,eax
    xor ecx,ecx
    xor edx,edx
    mov al,0xb
    int 0x80
    ret
loadstring:
    call execve
    ## .asciz "/bin/sh"

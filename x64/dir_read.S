BITS 64
global _start
_start:
    jmp loadstring
dir_read:
    pop rdi
    xor rax,rax
    xor rsi,rsi
    mov rdx,rdx
    mov al,0x2
    syscall
getdents:
    mov dl,0x7f
    mov rsi,rsp ; linux_dirent
    mov rdi,rax ; fd
    mov al,0x4e
    syscall
    cmp rax,1
    jl end
    mov r10,rsp
    lea r8,[rax+r10]  ; nread
next_ent:
    lea rsi,[r10+0x12] ; d_name
write:
    xor rdx,rdx
    mov dl,0x1  ; count
    mov dil,0x1 ; fd
    xor rax,rax
    mov al,0x1
    syscall
    inc rsi
    mov al,byte [rsi]
    test al,al
    jnz write

    lea rsi,[rdx+0x9] ; '\n'
    push rsi
    mov rsi,rsp
    mov al,0x1
    syscall
    add rsp, 8

    xor rsi,rsi
    mov si,word [r10+0x10] ; d_reclen
    add r10,rsi
    cmp r10,r8
    jl next_ent
    jmp getdents
end:
    ret
loadstring:
    call dir_read
    db ".",0

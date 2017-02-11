.intel_syntax noprefix
.globl _start
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
    mov dx,0x4000
    mov rsi,rsp # linux_dirent
    mov rdi,rax # fd
    mov al,0x4e
    syscall
    test rax,rax
    jle end
    mov r10,rsp
    lea r8,[rax+r10]  # nread
next_ent:
    lea rsi,[r10+0x12] # d_name
write:
    xor rdx,rdx
    mov dl,0x1  # count
    mov dil,0x1 # fd
    xor rax,rax
    mov al,0x1
    syscall
    inc rsi
    mov al,byte ptr [rsi]
    test al,al
    jnz write

    lea rsi,[rdx+0x9] # '\n'
    push rsi
    mov rsi,rsp
    mov al,0x1
    syscall
    add rsp, 8

    xor rsi,rsi
    movzx rsi,word ptr [r10+0x10] # d_reclen
    add r10,rsi
    cmp r10,r8
    jl next_ent
    jmp getdents
end:
    ret
loadstring:
    call dir_read
    .asciz "."

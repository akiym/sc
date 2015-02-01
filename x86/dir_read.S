BITS 32
global _start
_start:
    jmp loadstring
dir_read:
    pop ebx
    xor eax,eax
    xor ecx,ecx
    xor edx,edx
    mov al,0x5
    int 0x80

    mov dl,0x7f
    mov ecx,esp ; old_linux_dirent
    mov ebx,eax ; fd
    mov al,0x59
opendir:
    pushad ; store fd
    int 0x80
    test eax,eax
    jz end

    movzx dx,[ecx+0x8]    ; d_namlen
    mov bl,0x1
    lea ecx,[ecx+ebx+0x9] ; d_name
    mov al,0x4
    int 0x80

    mov dl,0x1
    lea ecx,[edx+0x9]
    push ecx
    mov ecx,esp
    mov al,0x4
    int 0x80
    add esp,0x4

    popad
    jmp opendir
end:
    ret
loadstring:
    call dir_read
    db ".", 0

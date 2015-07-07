BITS 32
global _start
_start:
    xor eax,eax
    xor ebx,ebx
    mov ecx,esp
    xor edx,edx
    mov dl,0xff
    mov al,0x3 ; read
    int 0x80
    mov byte [esp+eax-1], 0x0 ; remove trailling newline

    xor eax,eax
    mov ebx,esp
    xor ecx,ecx
    mov al,0x5 ; open
    int 0x80
    test eax,eax
    js _start
    mov esi,eax ; fd

file_read:
    xor eax,eax
    mov ebx,esi ; fd
    mov ecx,esp
    xor edx,edx
    inc edx
    shl edx,0xc
    mov al,0x3 ; read
    int 0x80
    test eax,eax
    js dir_read

    xchg eax,edx
    mov bl,0x1
    xor eax,eax
    mov al,0x4 ; write
    int 0x80

    mov ebx,esi
    mov al,0x6
    int 0x80
    jmp _start

dir_read:
    xor eax,eax
    mov dl,0x7f
    mov ecx,esp ; old_linux_dirent
    mov ebx,esi ; fd
    mov al,0x59 ; old_readdir
opendir:
    pushad ; store fd
    int 0x80
    test eax,eax
    jz _start

    movzx dx,[ecx+0x8]    ; d_namlen
    mov bl,0x1
    lea ecx,[ecx+ebx+0x9] ; d_name
    mov al,0x4 ; write
    int 0x80

    mov dl,0x1
    lea ecx,[edx+0x9]
    push ecx
    mov ecx,esp
    mov al,0x4 ; write
    int 0x80
    add esp,0x4

    popad
    jmp opendir

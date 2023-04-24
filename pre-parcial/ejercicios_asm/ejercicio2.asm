section .data
    vector: dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15

section .text
global _start

_start:
    mov ebx, vector ; guarda direccion de memoria del vector
    mov rax, 0
    mov r8, 0
    mov ecx, 0
    .cycle:
        cmp ecx, 0x10
        je .end
        mov rdx, rax
        add rax, [ebx + ecx*4]
        cmp rdx, rax
        jg .carry
        inc ecx
        jmp .cycle

    .carry:
        inc r8
        inc ecx
        jmp .cycle

    .end:
        mov eax, 60
        mov edi, 0
        syscall

section .data
    vector: dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15

section .text
global _start

_start:
    mov rdi, vector ; guarda direccion de memoria del vector
    mov eax, 0
    mov rcx, 0
    .cycle:
        cmp rcx, 0x40
        je .end
        add eax, [rdi + rcx] 
        add rcx, 0x4
        jmp .cycle

    .end:
        mov rax, 60
        mov rdi, 0
        syscall

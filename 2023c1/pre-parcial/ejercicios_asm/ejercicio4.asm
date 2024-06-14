section .data
    vector: dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15

section .text
global _start

_start:
    mov rdi, vector ; guarda direccion de memoria del vector
    
    sub rsp, 0x40
    mov rcx, 0x40
    .pushs:
        cmp rcx, 0
        je .sum
        sub rcx, 0x4
        mov eax, [rdi + rcx]
        push rax
        jmp .pushs
    
    .sum:
        mov rdi, 0
        mov rcx, 0x40
    .pops:
        cmp rcx, 0
        je .end
        sub rcx, 0x4
        pop rax
        add rdi, rax
        jmp .pops
    
    .end:
        add rsp, 0x40
        mov rax, 60
        mov rdi, 0
        syscall

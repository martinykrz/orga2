section .data
    vector: dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15

section .text
global _start

_start:
    mov rdi, vector ; guarda direccion de memoria del vector
    mov rsi, [rdi]
    mov rdx, [rdi + 0x4]
    mov rcx, [rdi + 0x8]
    mov r8, [rdi + 0xc]
    mov r9, [rdi + 0x10]
    sub rsp, 0x30
    mov eax, [rdi + 0x14]
    push rax
    mov eax, [rdi + 0x18]
    push rax
    mov eax, [rdi + 0x1c]
    push rax
    mov eax, [rdi + 0x20]
    push rax
    mov eax, [rdi + 0x24]
    push rax
    mov eax, [rdi + 0x28]
    push rax
    mov eax, [rdi + 0x2c]
    push rax
    mov eax, [rdi + 0x30]
    push rax
    mov eax, [rdi + 0x34]
    push rax
    mov eax, [rdi + 0x38]
    push rax
    mov eax, [rdi + 0x3c]
    push rax
    
    mov rdi, 0
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    pop rax
    add rdi, rax
    add rsp, 0x30
    
    add rdi, rsi
    add rdi, rdx
    add rdi, rcx
    add rdi, r8
    add rdi, r9

    .end:
        mov rax, 60
        mov rdi, 0
        syscall

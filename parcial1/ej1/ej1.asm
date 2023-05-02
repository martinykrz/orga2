global templosClasicos
global cuantosTemplosClasicos

extern malloc

;########### SECCION DE TEXTO (PROGRAMA)
section .text

templosClasicos:
    push rbp
    mov rbp, rsp

    call cuantosTemplosClasicos

    push rdi
    push rsi

    mov rdi, rax
    imul rdi, 0x18
    sub rsp, 8
    call malloc
    add rsp, 8

    pop rsi
    pop rdi

    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9

    .iter:
        cmp rdx, rsi
        je .fin
        mov r8, [rdi + rcx] ; colum_largo
        mov r9, [rdi + rcx + 0x10] ; colum_corto
        shl r9, 1
        inc r9
        cmp r9, r8
        je .class
        add rcx, 0x18
        inc rdx
        jmp .iter
    
    .class:
        push rdi
        push rsi

        mov rsi, rdi
        mov rdi, rax
        rep movsb

        pop rsi
        pop rdi

        add rcx, 0x18
        inc rdx
        jmp .iter

    .fin:
        pop rbp
        ret

;temploArr[rdi], temploArr_len[rsi]
cuantosTemplosClasicos:
    push rbp
    mov rbp, rsp
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9

    .ciclo:
        cmp rdx, rsi
        je .end
        mov r8, [rdi + rcx] ; colum_largo -> offset 0
        mov r9, [rdi + rcx + 0x10] ; colum_corto -> offset 16
        shl r9, 1
        inc r9
        ;dec r8
        ;shr r8, 1
        cmp r9, r8
        je .clasico
        add rcx, 0x18 ; 0x18 -> tamaño del struct
        inc rdx
        jmp .ciclo
         
    .clasico:
        inc rax
        add rcx, 0x18
        inc rdx
        jmp .ciclo

    .end:
        pop rbp
        ret

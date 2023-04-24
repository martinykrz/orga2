section .text

global cesar

cesar:
    push rbp
    mov rbp, rsp
    mov rcx, 0
    mov rdx, 0

    .modulo:
        cmp rsi, 26
        jl .cifrado
        sub rsi, 26
        jmp .modulo

    .cifrado:
        ;TODO
        ; Length of rdi
        ; Subtract rsp with length
        ; Add to the stack
        cmp [rdi + rcx], byte 0
        je .end
        mov dl, byte [rdi + rcx]
        add dl, sil
        inc rcx
        jmp .cifrado

    .end:
        mov rax, rdi

    pop rbp
    ret

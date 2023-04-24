section .text

global cesar

cesar:
    push rbp
    mov rbp, rsp
    mov rax, 0
    mov rcx, 4

    mov rax, [rdi]
    .cycle:
        add rax, rsi
        shl rsi, 8
    loop .cycle

    ; .modulo:
    ;     cmp rsi, 26
    ;     jl .length
    ;     sub rsi, 26
    ;     jmp .modulo

    ; .length:
    ;     cmp [rdi + rcx], byte 0
    ;     je .cifrado
    ;     inc rcx
    ;     jmp .length

    ; .zero:
    ;     dec rcx 
    ;     jmp .cifrado

    ; .cifrado:
    ;     add al, [rdi + rcx]
    ;     cmp al, byte 0
    ;     je .zero
    ;     add al, sil
    ;     shl rax, 8
    ; loop .cifrado

    ; add al, [rdi]
    ; add al, sil

    mov [rdi], rax
    
    pop rbp
    ret

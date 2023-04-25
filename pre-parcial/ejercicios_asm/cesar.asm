extern malloc
extern free

section .text

global cesar
global clean

cesar:
    push rbp
    mov rbp, rsp
    mov rcx, 0

    .modulo:
        cmp rsi, 26
        jl .length
        sub rsi, 26
        jmp .modulo

    .length:
        cmp [rdi + rcx], byte 0
        jz .copy
        inc rcx
        jmp .length

    .copy:
        push rdi
        push rsi
        inc rcx
        push rcx
        mov rdi, rcx

        sub rsp, 8
        call malloc wrt ..plt
        add rsp, 8

        pop rcx
        pop rsi
        pop rdi

        push rsi
        push rcx

        mov rsi, rdi
        mov rdi, rax
        rep movsb

        pop rcx
        dec rcx
        pop rsi

    .cycle:
        add [rax], rsi
        shl rsi, 8
    loop .cycle

    pop rbp
    ret

clean:
    push rbp
    mov rbp, rsp

    call free wrt ..plt

    pop rbp
    ret

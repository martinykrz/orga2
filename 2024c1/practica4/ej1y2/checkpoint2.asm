section .rodata
value: times 16 db 0xf
one: times 16 db 0x1

section .text

global four_of_a_kind_asm

; uint32_t four_of_a_kind_asm(card_t *hands, uint32_t n);

; rdi: card_t *hands, rsi: uint32_t n
four_of_a_kind_asm:
    push rbp
    mov rbp, rsp
    
    mov rcx, rsi
    shr rcx, 2
    xor rax, rax
    movdqu xmm1, [value]
    movdqu xmm3, [one]
    
    .cycle:
        movdqu xmm0, [rdi]
        ; extract value
        pand xmm0, xmm1
        ; inicializo r8 => 0, xmm4 => 1...1
        xor r8, r8
        movdqa xmm4, xmm3
        .compare:
            cmp r8, 13
            je .next
            ; copia xmm0 -> xmm2
            movdqa xmm2, xmm0
            ; chequea si alguno tiene 4 valores iguales en la hand
            pcmpeqb xmm2, xmm4
            mov r9, 4
            .check:
                cmp r9, byte 0
                je .continue
                ; extrae el resultado de la primera comparacion secuencial
                movd edx, xmm2
                ; si son todos iguales (0xffffffff) -> eax += 1
                cmp edx, 0xffffffff
                jne .hand
                inc eax
                .hand:
                    ; seguimos con la siguiente mano
                    psrldq xmm2, 4
                    dec r9
                    jmp .check
            .continue:
                ; incrementa los valores a comparar
                paddb xmm4, xmm3
                inc r8
                jmp .compare
        .next:
            add rdi, 16
    loop .cycle
    
    pop rbp
	ret

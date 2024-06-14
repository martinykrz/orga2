
section .text

global dot_product_asm

; uint32_t dot_product_asm(uint16_t *p, uint16_t *q, uint32_t length);
; implementacion simd de producto punto

; rdi: uint16_t *p, rsi: uint16_t *q, rdx: uint32_t length
dot_product_asm:
    push rbp
    mov rbp, rsp
    mov rcx, rdx
    shr rcx, 3
    xor rax, rax
    .cycle:
        ; muevo valores rdi/rsi -> xmm0/1
        movdqu xmm0, [rdi]
        movdqu xmm1, [rsi]
        ; multiplico por word xmm0 y xmm1
        ; guarda la parte baja de la misma
        pmullw xmm0, xmm1
        ; word -> double word, primeros 4 numeros
        pmovzxwd xmm1, xmm0
        psrldq xmm0, 8
        ; word -> double word, ultimos 4 numeros
        pmovzxwd xmm0, xmm0
        ; suma horizontal por double world
        ; dos veces para que se sume todo y tener 4 veces el resultado
        ; primeros 4
        phaddd xmm1, xmm1
        phaddd xmm1, xmm1
        ; ultimos 4
        phaddd xmm0, xmm0
        phaddd xmm0, xmm0
        ; sumo los resultados
        paddd xmm0, xmm1
        ; xmm0 -> 32-bit registro
        movd r8d, xmm0
        ; acumulador
        add eax, r8d
        ; next
        add rdi, 16
        add rsi, 16
    loop .cycle
    pop rbp
	ret

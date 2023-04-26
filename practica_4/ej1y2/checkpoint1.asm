section .text

global invertirBytes_asm

; void invertirBytes_asm(uint8_t* p, uint8_t n, uint8_t m)
invertirBytes_asm:
    push rbp
    mov rbp, rsp

    push r12
    push r13
    push r14

    mov rcx, 0
    mov r8, 0
    mov r9, 0
    mov r12, 0
    mov r13, 0
    mov r14, 0
    movdqu xmm0, [rdi] ; loads value
    movaps xmm1, xmm0
    .cycle:
        cmp rcx, rsi
        je .load_n
        cmp rcx, rdx
        je .load_m
    .index:
        cmp rcx, 15
        je .shuff
        pextrb r12, xmm1, 0
        psrldq xmm1, 1
        inc rcx
        jmp .cycle
    .load_n:
        pextrb r8, xmm1, 0
        jmp .index
    .load_m:
        pextrb r9, xmm1, 0
        jmp .index
    
    .shuff:
        movq xmm1, r8
        movq xmm2, r9
        mov rcx, 0x4
        .copy:
            punpcklbw xmm1, xmm1
            punpcklbw xmm2, xmm2
        loop .copy
        
        ; copy xmm1/2 -> xmm3/4
        movaps xmm3, xmm1
        movaps xmm4, xmm2

        ; compare byte a byte
        pcmpeqb xmm1, xmm0
        pcmpeqb xmm2, xmm0

        mov rcx, 0xff
        movq xmm5, rcx
        movaps xmm6, xmm5
        mov rcx, rsi
        .chck1:
            pslldq xmm5, 1
        loop .chck1
        mov rcx, rdx
        .chck2:
            pslldq xmm6, 1
        loop .chck2
        pand xmm1, xmm5
        pand xmm2, xmm6

        pand xmm3, xmm2 ; rsi -> i, xmm0[i] = rdx
        pand xmm4, xmm1 ; rdi -> j, xmm0[j] = rsi

        paddb xmm1, xmm2 ; i, j en el mismo registro
        paddb xmm3, xmm4 ; rsi, rdx en el mismo registro
        
        ; not xmm1
        pcmpeqb xmm2, xmm2 ; all 1
        pxor xmm1, xmm2
        
        pand xmm0, xmm1 ; xmm0[i] = 0, xmm0[j] = 0
        paddb xmm0, xmm3 ; xmm0[i] = rsi, xmm0[j] = rdx

    ; return value
    movdqa [rdi], xmm0

    pop rbp
    ret

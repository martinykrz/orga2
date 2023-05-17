section .text

global invertirBytes_asm

; void invertirBytes_asm(uint8_t* p, uint8_t n, uint8_t m)
; p[rdi], n[rsi], m[rdx]
invertirBytes_asm:
    push rbp
    mov rbp, rsp

    movdqu xmm0, [rdi]
    call values2XMM
    call makeMasks
    call applyMasks
    movdqa [rdi], xmm0

    pop rbp
    ret

values2XMM:
    ; init values
    xor r8, r8
    xor r9, r9
    movaps xmm3, xmm0
    movaps xmm4, xmm3

    ; search p[n]
    mov rcx, rsi
    cmp rsi, byte 0 
    je .first_n
    .value_n:
        psrldq xmm3, 1 ; shift 0xff to rsi-index
    loop .value_n
    .first_n:
        pextrb r8, xmm3, 0

    ; search p[m]
    mov rcx, rdx
    cmp rdx, byte 0
    je .first_m
    .value_m:
        psrldq xmm4, 1
    loop .value_m
    .first_m:
        pextrb r9, xmm4, 0

    ; cleaning
    pxor xmm3, xmm3
    pxor xmm4, xmm4

    cmp rsi, rdx
    je .igual
    jmp .continue

    ; if equal, no xmm4
    .igual:
        movq xmm3, r8
        mov r8, rsi
        mov r9, rdx
        mov rcx, 0x4
        .clone: ; making xmm3 to have all the r8 value
            punpcklbw xmm3, xmm3 
        loop .clone
        ret

    .continue:
        movq xmm3, r8
        movq xmm4, r9
        mov r8, rsi
        mov rcx, 0x4
        .copy: ; same but for both
            punpcklbw xmm3, xmm3
            punpcklbw xmm4, xmm4
        loop .copy
        ret

makeMasks:
    ; init
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm5, xmm5
    ; insert a 0xff to later apply mask
    mov rcx, 0xff
    movq xmm1, rcx
    movdqa xmm2, xmm1

    .mask_n:
        cmp rsi, byte 0
        je .equal
        pslldq xmm1, 1
        dec rsi
        jmp .mask_n
    
    ; same idea as before, only making one
    .equal:
        cmp r8, rdx
        je .end_equal

    .mask_m:
        cmp rdx, byte 0
        je .end
        pslldq xmm2, 1
        dec rdx
        jmp .mask_m
    
    .end_equal:
        paddb xmm5, xmm1
        ret

    .end:
        paddb xmm5, xmm1
        paddb xmm5, xmm2
        ret

applyMasks:
    pxor xmm6, xmm6
    cmp r8, r9
    jz .eq
    pand xmm3, xmm2
    jmp .next
    .eq:
        pand xmm3, xmm1
    .next:
    pand xmm4, xmm1
    paddb xmm6, xmm3
    paddb xmm6, xmm4

    pcmpeqb xmm7, xmm7
    pxor xmm5, xmm7

    pand xmm0, xmm5
    paddb xmm0, xmm6
    ret

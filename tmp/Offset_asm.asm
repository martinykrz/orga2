global Offset_asm

; Offset_asm(
;   uint8_t *src, [rdi]
;   uint8_t *dst, [rsi]
;   int width, [rdx]
;   int height, [rcx]
;   int src_row_size, [r8]
;   int dst_row_size [r9]
;)
; sizeof(bgra_t) = 4 => (value, offset): (b, 0), (g, 1), (r, 2), (a, 3)
; [rdi + i*src_row_size + j]
Offset_asm:
    push rbp
    mov rbp, rsp

    push r10
    push r11
    push r12
    push r13
    push r14
    push r15

    xor r12, r12
    add r12, 0x8 ; i = 8

    sub rcx, 0x8 ; height - 8
    sub rdx, 0x8 ; width - 8

    pxor xmm4, xmm4 ; Blue-Mask
    pxor xmm5, xmm5 ; Green-Mask
    pxor xmm6, xmm6 ; Red-Mask
    pxor xmm7, xmm7 ; Alpha

    mov r11, 0xFF
    movq xmm4, r11
    punpckldq xmm4, xmm4
    punpckldq xmm4, xmm4
    punpckldq xmm4, xmm4
     
    movdqa xmm5, xmm4
    pslldq xmm5, 1

    movdqa xmm6, xmm5
    pslldq xmm6, 1

    movdqa xmm7, xmm6
    pslldq xmm7, 1

    .iter_i:
        cmp r12, rcx
        je .end

        xor r13, r13
        add r13, 0x8 ; j = 8

        ; i + 8
        mov r14, r12
        add r14, 0x8
        imul r14, r8

        ; dst
        pxor xmm0, xmm0

        ; src
        pxor xmm1, xmm1 ; Blue
        pxor xmm2, xmm2 ; Green
        pxor xmm3, xmm3 ; Red

        .iter_j:
            cmp r13, rdx
            je .i_idx

            xor r10, r10
            mov r10, r12
            imul r10, r9
            add r10, r13
             
            ; j + 8
            mov r15, r13
            add r15, 0x8
             
            add r14, r13
            movdqu xmm1, [rdi + r14] ; src[i+8][j]
            sub r14, r13

            add r15, r12
            movdqu xmm2, [rdi + r15] ; src[i][j+8]
            sub r15, r12

            add r14, r15
            movdqu xmm3, [rdi + r14] ; src[i+8][j+8]
            sub r14, r15

            ; Apply maks to extract colours
            pand xmm1, xmm4
            pand xmm2, xmm5
            pand xmm3, xmm6

            paddq xmm0, xmm1 ; Add Blue
            paddq xmm0, xmm2 ; Add Green
            paddq xmm0, xmm3 ; Add Red
            paddq xmm0, xmm7 ; Add Alpha
             
            movdqa [rsi], xmm0 ; Apply Offset

            inc r13
            jmp .iter_j
             
        .i_idx:
            inc r12
            jmp .iter_i

    .end:
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop rbp
        ret


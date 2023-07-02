global Sharpen_asm
; void Sharpen_c(
;     uint8_t *src, [rdi]
;     uint8_t *dst, [rsi]
;     int width, [rdx]
;     int height, [rcx]
;     int src_row_size, [r8]
;     int dst_row_size [r9]
; )
make_masks:
    xor r10, r10
    pxor xmm6, xmm6 ; black pixels masks
     
    mov r10, 0xFF
    movq xmm6, r10
    punpckldq xmm6, xmm6
    punpckldq xmm6, xmm6
    punpckldq xmm6, xmm6
    pslldq xmm6, 3
     
    pxor xmm7, xmm7 ; cut masks
    pcmpeqb xmm7, xmm7

    pxor xmm8, xmm8 ; border
    xor r10, r10
    not r10
    movq xmm8, r10
    pslldq xmm8, 4
    pxor xmm8, xmm7
     
    pxor xmm9, xmm9 ; first black px
    movdqa xmm9, xmm7
    pslldq xmm9, 3

    pxor xmm10, xmm10 ; last black px
    movdqa xmm10, xmm7
    psrldq xmm10, 4
    por xmm10, xmm6

    ret

border:
    xor r10, r10
    .main_border:
        movups [rsi + r10], xmm6
        add r10, 4*4 ; 4(px) * 4(bytes cada px)
        cmp r10, r8
        jne .main_border
    ret

extract_pixels:
    ; clear xmm registers
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5

    ; top 4 pixels
    movdqu xmm0, [rdi + r11]
    movdqu xmm1, xmm0
    ; expand first 2 px
    pmovzxbw xmm0, xmm0
    psrldq xmm1, 8
    ; expand last 2 px
    pmovzxbw xmm1, xmm1

    ; middle 4 pixels
    add r11, r8
    movdqu xmm2, [rdi + r11]
    movdqu xmm3, xmm2
    ; expand fist 2 px
    pmovzxbw xmm2, xmm2
    psrldq xmm3, 8
    ; expand last 2 px
    pmovzxbw xmm3, xmm3

    ; bottom 4 pixels
    add r11, r8
    movdqu xmm4, [rdi + r11]
    movdqu xmm5, xmm4
    ; expand fist 2 px
    pmovzxbw xmm4, xmm4
    psrldq xmm5, 8
    ; expand last 2 px
    pmovzxbw xmm5, xmm5

    ret

middle_part:
    movdqa xmm11, xmm2
    movdqa xmm12, xmm3

    ; multiply by 9
    psllw xmm11, 3
    paddw xmm11, xmm2
    psllw xmm12, 3
    paddw xmm12, xmm3

    psrldq xmm11, 8 ; p5, 0
    pslldq xmm12, 8 ; 0, p6
     
    psubsw xmm11, xmm2 ; p5 - p4, -p5
    psubsw xmm12, xmm3 ; -p6, p6 - p7
    paddw xmm11, xmm12 ; p5 - p4 - p6, p6 - p7 - p5

    ret

long_sum:
    paddw xmm0, xmm4 ; p0 + p8, p1 + p9
    paddw xmm1, xmm5 ; p2 + p10, p3 + p11

    movdqa xmm13, xmm0
    paddw xmm13, xmm1 ; p0 + p8 + p2 + p10, p1 + p9 + p3 + p11

    psrldq xmm0, 8 ; p1 + p9, 0
    pslldq xmm1, 8 ; 0, p2 + p10
    por xmm0, xmm1 ; p1 + p9, p2 + p10

    paddw xmm13, xmm0 ; p0 + p8 + p1 + p9 + p2 + p10, p1 + p9 + p2 + p10 + p3 + p11
     
    ret

sharpen_filter:
    pxor xmm11, xmm11
    pxor xmm12, xmm12
    pxor xmm13, xmm13

    call middle_part
    call long_sum

    psubsw xmm11, xmm13 ; result
    movdqa xmm13, xmm11

    psrldq xmm11, 8
    pslldq xmm13, 8
     
    ret

to_dst:
    packuswb xmm11, xmm13
    sub r11, r8

    movdqu xmm0, [rsi + r11]
    pand xmm0, xmm8
    por xmm11, xmm0

    movups [rsi + r11], xmm11

    ret

Sharpen_asm:
    push rbp
    mov rbp, rsp

    call make_masks

    ; ignore black border
    sub rdx, 2
    sub rcx, 2

    call border

    push r12
    push rdi
    push rsi
    xor r12, r12
    .sharpen:
        xor r10, r10
        movdqu xmm0, [rsi + r8]
        pand xmm0, xmm9
        movups [rsi + r8], xmm0
        .pixels_line:
            mov r11, r10
            shl r11, 2
             
            call extract_pixels

            call sharpen_filter

            call to_dst
             
            add r10, 2
            cmp r10, rdx
            jne .pixels_line
         
        movdqu xmm0, [rsi + r11]
        pand xmm0, xmm10
        movups [rsi + r11], xmm0

        add rdi, r8
        add rsi, r8
        inc r12
        cmp r12, rcx
        jne .sharpen

    add rsi, r8
    call border

    pop rsi
    pop rdi
    pop r12

    pop rbp
	ret

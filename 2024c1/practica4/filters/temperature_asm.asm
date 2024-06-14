global temperature_asm

section .rodata
rgb: times 4 db 0xff, 0xff, 0xff, 0x0
_255: times 4 db 0xff, 0x0, 0x0, 0x0
_3: times 4 dd 0x3
_32: times 4 dd 0x20
_96: times 4 dd 0x60
_160: times 4 dd 0xa0
_224: times 4 dd 0xe0

; check_0: dd 0x20, 0x40, 0x20, 0x40

section .text
;void temperature_asm(unsigned char *src,
;              unsigned char *dst,
;              int width,
;              int height,
;              int src_row_size,
;              int dst_row_size);

; rdi: unsigned char *src, rsi: unsigned char *dst, rdx: int width
; rcx: int height, r8: int src_row_size, r9: int dst_row_size
temperature_asm:
    push rbp
    mov rbp, rsp

    push r10
    push r11
    
    mov r10, rcx

    movdqu xmm3, [_3] 
    cvtdq2ps xmm3, xmm3

    .cycle:
        cmp r10, byte 0
        je .end
        mov r11, rdx
        shr r11, 1
        .color:
            cmp r11, byte 0
            je .continue
            ; extraction
            movdqu xmm0, [rdi]
            movdqu xmm1, [rgb]
            movdqu xmm9, [_255]
            movdqa xmm15, xmm1
            pand xmm1, xmm0     ; rgb
            pandn xmm15, xmm0   ; alpha
            
            ; t value first and second px
            ; t = floor((r + g + b) / 3)
            .t_value:
                pmovzxbw xmm2, xmm1
                phaddw xmm2, xmm2
                phaddw xmm2, xmm2
                pmovzxwd xmm2, xmm2     ; r + g + b
                cvtdq2ps xmm2, xmm2
                divps xmm2, xmm3        ; (r + g + b) / 3
                cvttps2dq xmm2, xmm2    ; floor

            ; 0th => xmm10
            ; t < 32
            ; < b, g, r >
            ; < 128 + 4t, 0, 0 >
            .zeroth: 
                movdqa xmm4, xmm2
                movdqa xmm5, xmm2
                movdqu xmm10, [_32]
                
                pcmpgtw xmm5, xmm10         ; xmm5 -> t > 32
                
                pslld xmm4, 2               ; 4t
                pslld xmm10, 2
                paddusw xmm4, xmm10         ; 128 + 4t
                
                pandn xmm5, xmm4            ; xmm4 and ~(t > 32)
                movdqa xmm10, xmm5          ; ret xmm10

            ; 1st => xmm11
            ; 32 <= t < 96
            ; < b, g, r >
            ; < 255, 4(t - 32), 0 >
            .first: 
                movdqa xmm4, xmm2
                movdqa xmm5, xmm2
                movdqa xmm6, xmm2
                movdqu xmm11, [_32]
                movdqa xmm12, xmm11
                
                pcmpgtw xmm5, xmm11         ; xmm5 -> t > 32
                
                psubusw xmm4, xmm11
                pslld xmm4, 2               ; 4(t - 32)
                
                pslld xmm11, 1
                paddd xmm12, xmm11
                pcmpgtw xmm6, xmm12         ; xmm6 -> t > 96
                
                pand xmm5, xmm4             ; xmm4 and (t > 32)
                pandn xmm6, xmm5            ; (t > 32) and ~(t > 96)

                pslldq xmm6, 1
                por xmm6, xmm9
                
                movdqa xmm11, xmm6          ; ret xmm11

            ; 2nd => xmm12
            ; 96 <= t < 160
            ; < b, g, r >
            ; < 255 - 4(t - 96), 225, 4(t - 96) >
            .second:
                movdqa xmm4, xmm2
                movdqa xmm5, xmm2
                movdqa xmm6, xmm2
                movdqu xmm13, [_160]
                
                pcmpgtw xmm5, xmm12         ; xmm5 -> t > 96
                pcmpgtw xmm6, xmm13         ; xmm6 -> t > 160
                movdqa xmm7, xmm5           ; xmm7 -> t > 96
                movdqa xmm8, xmm6           ; xmm8 -> t > 160

                psubusw xmm4, xmm12
                psllw xmm4, 2               ; 4(t - 96)
                pand xmm5, xmm4             ; xmm4 and (t > 96)
                pandn xmm6, xmm5            ; (t > 96) and ~(t > 160)
                
                pcmpeqb xmm5, xmm5
                pmovzxbd xmm5, xmm5         ; 255
                psubusw xmm5, xmm4          ; 255 - 4(t - 96)
                pand xmm7, xmm5             ; xmm5 and (t > 96)
                pandn xmm8, xmm7            ; (t > 96) and ~(t > 160)
                
                pslldq xmm6, 2
                por xmm8, xmm6
                pslldq xmm9, 1
                por xmm8, xmm9

                movdqa xmm12, xmm8          ; ret xmm12

            ; 3rd => xmm13
            ; 160 <= t < 224
            ; < b, g, r >
            ; < 0, 255 - (t - 160), 255 >
            .third:
                movdqa xmm4, xmm2
                movdqa xmm5, xmm2
                movdqa xmm6, xmm2
                movdqu xmm14, [_224]
                
                pcmpgtw xmm5, xmm13         ; xmm5 -> t > 160
                pcmpgtw xmm6, xmm14         ; xmm6 -> t > 224

                psubusw xmm4, xmm13
                pslld xmm4, 2               ; 4(t - 160)
                
                pcmpeqd xmm7, xmm7
                pmovzxbd xmm7, xmm7
                psubusw xmm7, xmm4          ; 255 - 4(t - 160)
                pand xmm5, xmm7             ; xmm7 and (t > 160)
                pandn xmm6, xmm5            ; (t > 160) and ~(t > 224)

                pslldq xmm6, 1
                pslldq xmm9, 1
                por xmm6, xmm9
                
                movdqa xmm13, xmm6          ; ret xmm13

            ; 4th => xmm14
            ; t >= 224
            ; < b, g, r >
            ; < 0, 0, 255 - (t - 224) >
            .fourth:
                movdqa xmm4, xmm2
                movdqa xmm5, xmm2
                movdqa xmm6, xmm2
                
                pcmpgtw xmm5, xmm14         ; xmm5 -> t > 224
                pcmpeqd xmm6, xmm14         ; xmm6 -> t == 224
                
                psubusw xmm4, xmm14
                pslld xmm4, 2               ; 4(t - 224)
                pcmpeqb xmm7, xmm7
                pmovzxbd xmm7, xmm7
                psubusw xmm7, xmm4          ; 255 - 4(t - 224)
                
                pand xmm5, xmm7             ; xmm5 and (t > 224)
                por xmm6, xmm5              ; (t > 224) or (t == 224)

                pslldq xmm6, 2
                
                movdqa xmm14, xmm6          ; ret xmm14

            .combine:
                pxor xmm4, xmm4
                pcmpeqb xmm4, xmm10
                pandn xmm4, xmm10
                
                movdqu xmm5, [_255]
                movdqu xmm9, [_32]
                pcmpeqd xmm9, xmm2
                pcmpeqd xmm5, xmm11
                pandn xmm5, xmm11
                pand xmm9, xmm11
                por xmm5, xmm9

                movdqu xmm6, [_255]
                pslldq xmm6, 1
                movdqu xmm9, [_96]
                pcmpeqd xmm9, xmm2
                pcmpeqd xmm6, xmm12
                pandn xmm6, xmm12
                pand xmm9, xmm12
                por xmm6, xmm9

                movdqu xmm7, [_255]
                pslldq xmm7, 2
                movdqu xmm9, [_160]
                pcmpeqd xmm9, xmm2
                pcmpeqd xmm7, xmm13
                pandn xmm7, xmm13
                pand xmm9, xmm13
                por xmm7, xmm9

                pxor xmm8, xmm8
                pcmpeqb xmm8, xmm14
                pandn xmm8, xmm14

                por xmm4, xmm5
                por xmm6, xmm7
                por xmm4, xmm6
                por xmm4, xmm8

                ; psrldq xmm4, 8
                ; psrldq xmm15, 8
                movdqa xmm0, xmm4
                ; por xmm0, xmm15

            movdqu [rsi], xmm0
            add rdi, 8
            add rsi, 8
            dec r11
            jmp .color
        .continue:
            dec r10
            jmp .cycle
    
    .end:
        pop r11
        pop r10
        pop rbp
        ret

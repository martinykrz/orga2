section .rodata

section .text

global Pintar_asm

;void Pintar_asm(unsigned char *src,
;              unsigned char *dst,
;              int width,
;              int height,
;              int src_row_size,
;              int dst_row_size);

; rdi: unsigned char *src, rsi: unsigned char *dst, rdx: int width
; rcx: int height, r8: int src_row_size, r9: int dst_row_size
Pintar_asm:
    push rbp
    mov rbp, rsp

    push r10
    push r11
    push r12
    push r13
    push r14
    push r15

    mov r14, rsi

    pxor xmm0, xmm0
    pcmpeqb xmm1, xmm1
    
    mov r13, rdx
    shr r13, 2

    xor r12, r12
    .color:
        cmp r12, rcx
        je .border

        xor r11, r11
        .row:
            cmp r11, r13
            je .continue
            
            movdqu [rsi], xmm0
            
            add rsi, 16
            inc r11
        jmp .row
        
        .continue:
            inc r12
        jmp .color

    .border:
        mov rsi, r14

        mov r11, r9
        shl r11, 1
        add rsi, r11     ; rsi + 2px height

        mov r12, rcx
        sub r12, 4 

        movdqa xmm3, xmm1
        movdqa xmm4, xmm1

        pslldq xmm3, 8
        psrldq xmm4, 8

        .paint:
            cmp r12, byte 0
            je .end

            xor r11, r11
            .rows:
                cmp r11, r13
                je .columns

                movdqu [rsi], xmm1

                add rsi, 16
                inc r11
            jmp .rows

            .columns:
                mov r10, rsi
                sub r10, r9
                movdqu [r10], xmm3
                movdqu [rsi - 16], xmm4

            dec r12
            jmp .paint

    .end:
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10

        pop rbp
        ret

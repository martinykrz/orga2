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
Offset_asm:
    push rbp
    mov rbp, rsp

    push r10
    push r11
    push r12
    push r13
    push r14
    push r15

    call making_masks

    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7

    xor r10, r10 ; dst iter
    xor r11, r11 ; dst_row_size
    xor r12, r12 ; width
    xor r13, r13 ; height
    xor r14, r14
    xor r15, r15
     
    mov r11, r9
    shl r11, 3 ; dst_row_size * 8
    mov r12, rdx
    mov r13, rcx
    sub r12, 16 ; subtract border
    sub r13, 16 ; subtract border

    xor rax, rax
    .top_border:
        ; 8 filas negras
        movaps [rsi + r10], xmm4
        add r10, 16
        add rax, 2
        cmp rax, r8
        jne .top_border

    .offset_filter:
        ; left 8 black px
        movaps [rsi + r10], xmm4
        add r10, 16
        movaps [rsi + r10], xmm4
        add r10, 16

        xor rax, rax ; px counter
        .main:
            movdqu xmm0, xmm4 ; res
            movdqu xmm5, [rdi + r10 + 32] ; src[i][j+8]
            mov r14, r10
            add r14, r11 
            movdqa xmm6, [rdi + r14] ; src[i+8][j]
            add r14, 32
            movdqa xmm7, [rdi + r14] ; src[i+8][j+8]

            ; Offset itself
            pand xmm5, xmm1 ; blue
            pand xmm6, xmm2 ; green
            pand xmm7, xmm3 ; red
             
            ; Make result
            por xmm0, xmm5
            por xmm0, xmm6
            por xmm0, xmm7

            ; Send to dst
            movaps [rsi + r10], xmm0
            add r10, 16

            add rax, 4
            cmp rax, r12
            jne .main

        ; right 8 black px
        movaps [rsi + r10], xmm4
        add r10, 16
        movaps [rsi + r10], xmm4
        add r10, 16
         
        inc r15
        cmp r15, r13
        jne .offset_filter

    xor rax, rax
    .bottom_border:
        ; 8 filas negras
        movaps [rsi + r10], xmm4
        add r10, 16
        add rax, 2
        cmp rax, r8
        jne .bottom_border

    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
     
    pop rbp
    ret

making_masks:
    xor r10, r10
    pxor xmm1, xmm1 ; Blue-Mask
    pxor xmm2, xmm2 ; Green-Mask
    pxor xmm3, xmm3 ; Red-Mask
    pxor xmm4, xmm4 ; Alpha

    mov r10, 0xFF
    movq xmm1, r10
    punpckldq xmm1, xmm1
    punpckldq xmm1, xmm1
    punpckldq xmm1, xmm1
     
    movdqa xmm2, xmm1
    pslldq xmm2, 1

    movdqa xmm3, xmm2
    pslldq xmm3, 1

    movdqa xmm4, xmm3
    pslldq xmm4, 1

    ret


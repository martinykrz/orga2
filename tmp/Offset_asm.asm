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

    push r12
    push r13
    push r14

    ; init values of i,j 
    mov r12, rdx
    add r12, 0x4
    imul r12, 0x8

    ; height + 8
    mov r13, rdx
    imul r13, 0x8

    ; widht + 8
    mov r14, rdx
    add r14, 0x8

    ; source
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    movdqu xmm1, [rdi + r12 + r13 + 0x0] ; blue
    movdqu xmm2, [rdi + r12 + r14 + 0x1] ; green
    movdqu xmm3, [rdi + r12 + r13 + r14 + 0x2] ; red

    ; destination
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    movdqu xmm4, [rsi + r12 + 0x0] ; blue
    movdqu xmm5, [rsi + r12 + 0x1] ; green
    movdqu xmm6, [rsi + r12 + 0x2] ; red

    pop rbp
    ret


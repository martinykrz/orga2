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

    push r12
    xor r12, r12

    pxor xmm1, xmm1
    .iter:
        cmp r12, byte 0xff
        jg .end
        movdqu xmm1, [rdi + r12]
        add r12, 0x4
        jmp .iter
    .end:
        pop r12
        pop rbp
        ret


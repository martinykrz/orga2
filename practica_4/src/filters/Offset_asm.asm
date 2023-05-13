
global Offset_asm

; Offset_asm(uint8_t *src, uint8_t *dst, int width, int height, int src_row_size, int dst_row_size)
; src[rdi], dstp[rsi], width[rdx], height[rcx], src_row_size[r8], dst_row_size[r9]
Offset_asm:
    push rbp
    mov rbp, rsp

    pxor xmm0, xmm0

    movlqu xmm0, [rdi]

    pop rbp
	ret

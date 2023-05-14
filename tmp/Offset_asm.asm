
global Offset_asm

; Offset_asm(uint8_t *src, uint8_t *dst, int width, int height, int src_row_size, int dst_row_size)
; src[rdi], dstp[rsi], width[rdx], height[rcx], src_row_size[r8], dst_row_size[r9]
Offset_asm:
    push rbp
    mov rbp, rsp

    ; bgra_t (*src_matrix)[(src_row_size+3)/4] = (bgra_t (*)[(src_row_size+3)/4]) src
    
    ; bgra_t (*dst_matrix)[(dst_row_size+3)/4] = (bgra_t (*)[(dst_row_size+3)/4]) dst

    pop rbp
	ret

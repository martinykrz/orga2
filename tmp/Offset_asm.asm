extern malloc
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

    call init
    call offset

    pop rbp
	ret

init:
    ; src_row_size+3/4
    add r8, 0x3
    shr r8, 0x2
    ; dst_row_size+3/4
    add r9, 0x3
    shr r9, 0x2
    

offset:
    

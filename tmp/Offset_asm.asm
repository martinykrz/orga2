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
    push r13
    push r14
    push r15

    call makeMasks
    xor r12, r12
    add r12, 0x8

    xor r14, r14
    xor r15, r15
     
    sub rcx, 0x8 ; height - 8
    sub rdx, 0x8 ; width - 8
    .iter_i:
        cmp r12, rcx
        je .end
        
        xor r13, r13
        add r13, 0x8
        
        ; i + 8
        mov r14, r12
        add r14, 0x8
        imul r14, r8
        
        ; src
        pxor xmm1, xmm1
        pxor xmm2, xmm2
        pxor xmm3, xmm3
        
        ; dst
        pxor xmm4, xmm4
        
        .iter_j:
            cmp r13, rdx
            je .i_idx
            
            ; j + 8
            mov r15, r13
            add r15, 0x8
            
            add r14, r13
            movdqu xmm1, [rdi + r14] ; src[i+8][j]
            sub r14, r13
            
            xor rax, rax
            add rax, r12
            imul rax, r8
            add rax, r15
            movdqu xmm2, [rdi + rax] ; src[i][j+8]
            
            add r14, r15
            movdqu xmm3, [rdi + r14] ; src[i+8][j+8]
            sub r14, r15
            
            xor rax, rax
            add rax, r12
            imul rax, r9
            add rax, r13
            movdqu xmm4, [rsi + rax] ; dst[i][j]
            
            inc r13
            jmp .iter_j

        .i_idx:
            inc r12
            jmp .iter_i

    .end:
        xor rax, rax
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbp
        ret

makeMasks:
    pxor xmm5, xmm5
    movd xmm5, 0xff000000
    punpckldq xmm5, xmm5


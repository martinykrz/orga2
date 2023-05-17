
section .text

global checksum_asm

; uint8_t checksum_asm(void* array, uint32_t n)
; array[rdi], n[rsi]
checksum_asm:
    push rbp
    mov rbp, rsp

    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx

    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    
    .iter:
        cmp rcx, rsi
        je .end
    
        movdqu xmm0, [rdi + rdx] ; a
        movdqu xmm1, [rdi + rdx + 0x10] ; b
        movdqu xmm2, [rdi + rdx + 0x20] ; c[0:15]
        movdqu xmm3, [rdi + rdx + 0x30] ; c[16:32]

        paddw xmm0, xmm1 ; a + b
        psllw xmm0, 3 ; (a + b) * 8

        pxor xmm4, xmm4
        pxor xmm5, xmm5

        packusdw xmm2, xmm4 ; packed on front
        packusdw xmm5, xmm3 ; packed on back
        paddw xmm2, xmm5 ; packed c from double -> word

        pcmpeqw xmm0, xmm2 ; compare operation with c

        xor r8, r8
        xor r9, r9
        mov r9, rcx
        mov rcx, 0x10
        .check:
            pextrb r8, xmm0, 0
            cmp byte r8, 0xff
            jne .error
            psrldq xmm0, 1
        loop .check
        mov rcx, r9

        .equal:
            mov rax, 1
            inc rcx
            add rdx, 0x40
            jmp .iter

        .error:
            xor rax, rax
            jmp .end

    .end:
        pop rbp
	    ret

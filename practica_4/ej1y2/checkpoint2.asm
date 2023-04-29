
section .text

global checksum_asm

; uint8_t checksum_asm(void* array, uint32_t n)
; array[rdi], n[rsi]
checksum_asm:
    push rbp
    mov rbp, rsp

    xor rax, rax

    pxor xmm0, xmm0
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5

    movdqu xmm0, [rdi] ; a
    movdqu xmm1, [rdi + 0x10] ; b
    movdqu xmm2, [rdi + 0x20] ; c[0:15]
    movdqu xmm3, [rdi + 0x30] ; c[16:32]

    paddw xmm0, xmm1
    psllw xmm0, 3

    packusdw xmm4, xmm2
    packusdw xmm3, xmm5
    paddw xmm3, xmm4

    pcmpeqw xmm0, xmm3

    xor rdx, rdx
    xor rcx, rcx
    movq rdx, xmm0
    psrldq xmm0, 8
    movq rcx, xmm0

    cmp rdx, rcx
    je .equal
    jmp .end

    .equal:
        inc rax

    .end:
        pop rbp
	    ret

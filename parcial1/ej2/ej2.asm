global miraQueCoincidencia



;########### SECCION DE TEXTO (PROGRAMA)
section .text

; A[rdi], B[rsi], N[rdx], laCoincidencia[rcx]
miraQueCoincidencia:
    push rbp
    mov rbp, rsp
    pxor xmm0, xmm0
    pxor xmm1, xmm1
    
    movdqu xmm0, [rdi]
    movdqu xmm1, [rsi]

    pop rbp
    ret
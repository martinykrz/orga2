global miraQueCoincidencia



;########### SECCION DE TEXTO (PROGRAMA)
section .text

; A[rdi], B[rsi], N[rdx], laCoincidencia[rcx]
; bgra_t(32bits) = {b, g, r, a} (4 * 8bits) 
miraQueCoincidencia:
    push rbp
    mov rbp, rsp
    pxor xmm0, xmm0
    pxor xmm1, xmm1

    ;TODO
    ; En un ciclo, 
    ;   * Almacenar en un xmm A y B
    ;   * Comparar a 32 bits
    ;   * Si son iguales,
    ;       - Guardar el ultimo byte
    ;       - Borrar el ultimo byte
    ;       - Hacer el calculo y reemplazar los 24 bits restantes con el res
    ;       - Sumarle o devolcerle el byte guardado
    ;   * Sino,
    ;       - Transformar cada byte (a tambien?) en 255 (0xff)
    ;   * Almacenar el resultado en rcx en el lugar que corresponda
    ;   * Iterar de vuelta

    pop rbp
    ret

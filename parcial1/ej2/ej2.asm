global miraQueCoincidencia



;########### SECCION DE TEXTO (PROGRAMA)
section .text

; A[rdi], B[rsi], N[rdx], laCoincidencia[rcx]
; bgra_t(32bits) = {b, g, r, a} (4 * 8bits) 
miraQueCoincidencia:
    push rbp
    mov rbp, rsp

    xor r8, r8
    xor r9, r9

    mov r8, [rdi]
    mov r9, [rsi]
    cmp r8, r9
    je .equal

    .equal:
        push r12
        push r13

        xor r9, r9
        pxor xmm0, xmm0
        pxor xmm1, xmm1
        pxor xmm2, xmm2
        pxor xmm3, xmm3

        movdqu xmm0, r8

        .cycle:
            pextrb r9, xmm0, 0
            psrldq xmm0, 1
            movdqu xmm1, r9 ; if blue
            movdqu xmm2, r9 ; if green
            movdqu xmm3, r9 ; if red
            mov r12, r9 ; if a_1
            mov r13, r9 ; if a_2
            jmp .cycle
        
        .operacion:
            call cuentas
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

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
        push r14
        push r15

        pxor xmm0, xmm0
        pxor xmm1, xmm1
        pxor xmm2, xmm2
        pxor xmm3, xmm3

        movq xmm0, r8
        xor r14, r14

        .cycle:
            cmp r14, byte 0x8
            je .end
            ; je .operation
            xor r9, r9
            pextrb r9, xmm0, 0
            psrldq xmm0, 1
            cmp r14, byte 0x0
            je .blue
            cmp r14, byte 0x4
            je .blue
            cmp r14, byte 0x1
            je .green
            cmp r14, byte 0x5
            je .green
            cmp r14, byte 0x2
            je .red
            cmp r14, byte 0x6
            je .red
            cmp r14, byte 0x3
            je .transparency_a
            cmp r14, byte 0x7
            je .transparency_b
         
        .blue:
            movq xmm1, r9
            inc r14
            jmp .cycle
        
        .green:
            movq xmm2, r9
            inc r14
            jmp .cycle
            
        .red:
            movq xmm3, r9
            inc r14
            jmp .cycle

        .transparency_a:
            mov r12, r9
            inc r14
            jmp .cycle

        .transparency_b:
            mov r13, r9
            inc r14
            jmp .cycle

        ; .operacion:
            ; call cuentas
    
    .end:
        pop rbp
        ret

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

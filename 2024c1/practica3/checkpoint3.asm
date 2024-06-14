

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar:
NODO_LENGTH	EQU	0x30
LONGITUD_OFFSET	EQU	0x18

PACKED_NODO_LENGTH	EQU	0x15
PACKED_LONGITUD_OFFSET	EQU	0x11

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[rdi]
cantidad_total_de_elementos:
    push rbp
    mov rbp, rsp

    xor rax, rax
    xor rsi, rsi
    xor rcx, rcx

    mov rsi, [rdi]
    .cycle:
        cmp rsi, byte 0
        je .end
        add ecx, [rsi + LONGITUD_OFFSET]
        mov rsi, [rsi]
        jmp .cycle
    
    .end:
        mov eax, ecx

    pop rbp
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[rdi]
cantidad_total_de_elementos_packed:
    push rbp
    mov rbp, rsp

    xor rax, rax
    xor rsi, rsi
    xor rcx, rcx

    mov rsi, [rdi]
    .cycle:
        cmp rsi, byte 0
        je .end
        add ecx, [rsi + PACKED_LONGITUD_OFFSET]
        mov rsi, [rsi]
        jmp .cycle
    
    .end:
        mov eax, ecx

    pop rbp
	ret

section .data
 nombre: db "Martin", 0xa 
 nombreLen: equ $ - nombre
 apellido: db "Yaciuk Rodriguez", 0xa
 apellidoLen: equ $ - apellido
 libreta: db "26/20", 0xa
 libretaLen: equ $ - libreta
 frase: db "Feliz Jueves! - Azuka", 0xa
 fraseLen: equ $ - frase

 section .text
  global _start
  _start:
    mov     rax,1
    mov     rdi,1
    mov     rsi,nombre
    mov     rdx,nombreLen
    syscall

    mov     rax,1
    mov     rdi,1
    mov     rsi,apellido
    mov     rdx,apellidoLen
    syscall

    mov     rax,1
    mov     rdi,1
    mov     rsi,libreta
    mov     rdx,libretaLen
    syscall

    mov     rax,1
    mov     rdi,1
    mov     rsi,frase
    mov     rdx,fraseLen
    syscall

    mov     rax,60
    mov     rdi,0
    syscall

section .data
 hello: db "Hello, World!", 0xa ;string to print
 helloLen: equ $ - hello ;length of string ($ means the current location)

section .text
 global _start ;start in _start
 _start:
    mov     rax,1 ;sys_write
    mov     rdi,1 ;stdout
    mov     rsi,hello ;message to write
    mov     rdx,helloLen ;message length
    syscall ;call kernel
    ;end program
    mov     rax,60 ;sys_exit
    mov     rdi,0 ;error code 0 (success)
    syscall

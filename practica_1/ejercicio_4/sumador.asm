section .text
 global _start
 _start:
    mov     bl,255  
    add     bl,1        ;Carry Flag, Zero Flag
    mov     rbx,0xffffffffffffffff
    add     rbx,1 
    add     rbx,-1
    add     rbx,0
    syscall
    
    mov     rax,60
    mov     rdi,0
    syscall

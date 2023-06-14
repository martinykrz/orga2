; ** por compatibilidad se omiten tildes **
; ==============================================================================
; TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
; ==============================================================================

%include "print.mac"

global start


; COMPLETAR - Agreguen declaraciones extern según vayan necesitando
extern GDT_DESC
extern A20_enable
extern screen_draw_layout
extern idt_init
extern IDT_DESC
extern pic_reset
extern pic_enable
extern mmu_init
extern mmu_init_kernel_dir
extern mmu_init_task_dir
extern mmu_map_page
extern mmu_unmap_page
extern copy_page
extern tss_init
extern tasks_screen_draw
extern tss_create_user_task
extern sched_init
extern tasks_init

; COMPLETAR - Definan correctamente estas constantes cuando las necesiten
%define CS_RING_0_SEL  0x08  
%define DS_RING_0_SEL  0x18  

%define IDLE_SEL  12 << 3
%define INITIAL_SEL  11 << 3

BITS 16
;; Saltear seccion de datos
jmp start

;;
;; Seccion de datos.
;; -------------------------------------------------------------------------- ;;
start_rm_msg db     'Iniciando kernel en Modo Real'
start_rm_len equ    $ - start_rm_msg

start_pm_msg db     'Iniciando kernel en Modo Protegido'
start_pm_len equ    $ - start_pm_msg

;;
;; Seccion de código.
;; -------------------------------------------------------------------------- ;;

;; Punto de entrada del kernel.
BITS 16
start:
    ; Deshabilita interrupciones
    cli

    ; Cambia modo de video a 80 X 50
    mov ax, 0003h
    int 10h ; set mode 03h
    xor bx, bx
    mov ax, 1112h
    int 10h ; load 8x8 font

    ; Imprime mensaje de bienvenida - MODO REAL - (print.mac func)
    print_text_rm start_rm_msg, start_rm_len, 1, 0, 0

    ; Habilita A20 (a20.asm)
    call A20_enable

    ; Carga la GDT
    lgdt [GDT_DESC]

    ; Setea el bit PE del registro CR0
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Salta a modo protegido (far jump)
    ; (recuerden que un far jmp se especifica como jmp CS_selector:address)
    ; Pueden usar la constante CS_RING_0_SEL definida en este archivo
    jmp CS_RING_0_SEL:modo_protegido

BITS 32
modo_protegido:
    ; A partir de aca, todo el codigo se va a ejectutar en modo protegido
    ; Establecer selectores de segmentos DS, ES, GS, FS y SS en el segmento de datos de nivel 0
    ; Pueden usar la constante DS_RING_0_SEL definida en este archivo
    mov ax, DS_RING_0_SEL
    mov ds, ax
    mov es, ax
    mov gs, ax
    mov fs, ax
    mov ss, ax

    ; Establecer el tope y la base de la pila
    mov esp, 0x25000
    mov ebp, esp

    ; Imprime mensaje de bienvenida - MODO PROTEGIDO
    print_text_pm start_pm_msg, start_pm_len, 1, 0, 0

    ; Inicializar pantalla
    call screen_draw_layout

    ; Paginacion
    ; Init MMU
    call mmu_init

    ; Init Page Directory
    call mmu_init_kernel_dir

    ; Cargamos el Page Directory, eax tiene el address del Page Diretory
    mov cr3, eax

    ; Habilitamos paginacion
    mov eax, cr0
    or eax, 0x80000000 ; 0x80000000 es 1 con 30 ceros
    mov cr0, eax

    ; Init TSS
    call tss_init
    call tasks_screen_draw
    
    ; Init Scheduler
    call sched_init
    call tasks_init

    ; Cargar IDT
    call idt_init
    lidt [IDT_DESC]

    ; Inicializacion del PIC
    call pic_reset
    call pic_enable

    ; Aceleramos el PIT (Programmable Interrupt Timer)
    ; El PIT corre a 1193182Hz.
    ; Cada iteracion del clock decrementa un contador interno, cuando este llega
    ; a cero se emite la interrupcion. El valor inicial es 0x0 que indica 65536,
    ; es decir 18.206Hz
    mov ax, 10
    out 0x40, al
    rol ax, 8
    out 0x40, al
    
    ; TASK INITIAL
    mov ax, INITIAL_SEL
    ltr ax

    ; TASK IDLE
    jmp IDLE_SEL:0

    ; Activamos interrupciones
    sti

    ; Ciclar infinitamente 
    mov eax, 0xFFFF
    mov ebx, 0xFFFF
    mov ecx, 0xFFFF
    mov edx, 0xFFFF
    jmp $

;; -------------------------------------------------------------------------- ;;

%include "a20.asm"

/* ** por compatibilidad se omiten tildes **
================================================================================
 TALLER System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================

  Definicion de estructuras para administrar tareas
*/

#include "tss.h"
#include "defines.h"
#include "kassert.h"
#include "mmu.h"

/*
 * TSS de la tarea inicial (sólo se usa para almacenar el estado del procesador
 * al hacer el salto a la tarea idle
 */
tss_t tss_initial = {0};
// TSS de la tarea idle
tss_t tss_idle = {
    .ss1 = 0,
    .cr3 = KERNEL_PAGE_DIR,
    .eip = TASK_IDLE_CODE_START,
    .eflags = EFLAGS_IF,
    .esp = KERNEL_STACK,
    .ebp = KERNEL_STACK,
    .cs = GDT_CODE_0_SEL,
    .ds = GDT_DATA_0_SEL,
    .es = GDT_DATA_0_SEL,
    .gs = GDT_DATA_0_SEL,
    .fs = GDT_DATA_0_SEL,
    .ss = GDT_DATA_0_SEL,
};
// Lista de tss, de aquí se cargan (guardan) las tss al hacer un cambio de contexto
tss_t tss_tasks[MAX_TASKS] = {0};

//void tss_gdt_entry_for_task(size_t gdt_id, tss_t* tss) {
gdt_entry_t tss_gdt_entry_for_task(tss_t* tss) {
    /*
    gdt[gdt_id].g = 0;
    gdt[gdt_id].limit_15_0 = sizeof(tss_t) - 1;
    gdt[gdt_id].limit_19_16 = 0x0;
    gdt[gdt_id].base_15_0 = GDT_BASE_LOW(tss);
    gdt[gdt_id].base_23_16 = GDT_BASE_MID(tss);
    gdt[gdt_id].base_31_24 = GDT_BASE_HIGH(tss);
    gdt[gdt_id].p = 1;
    gdt[gdt_id].type = DESC_TYPE_32BIT_TSS;
    gdt[gdt_id].s = DESC_SYSTEM;
    gdt[gdt_id].dpl = 0;
    */ 
    return (gdt_entry_t) {
        .g = 0,
        .limit_15_0 = sizeof(tss_t) - 1,
        .limit_19_16 = 0x0,
        .base_15_0 = GDT_BASE_LOW(tss),
        .base_23_16 = GDT_BASE_MID(tss),
        .base_31_24 = GDT_BASE_HIGH(tss),
        .p = 1,
        .type = DESC_TYPE_32BIT_TSS, // CODE, Execute-Only, accessed
        .s = DESC_SYSTEM, // 0
        .dpl = 0,
    };
}

/**
 * Define el valor de la tss para el indice task_id
 */
void tss_set(tss_t tss, int8_t task_id) {
    kassert(task_id >= 0 && task_id < MAX_TASKS, "Invalid task_id");

    tss_tasks[task_id] = tss;
}

/**
 * Crea una tss con los valores por defecto y el eip code_start
 */
//void tss_create_user_task(int8_t task_id, paddr_t code_start) {
tss_t tss_create_user_task(paddr_t code_start) {
    // PD del task
    uint32_t cr3 = mmu_init_task_dir(code_start);
    // Donde comienza el stack del task
    vaddr_t stack = TASK_STACK_BASE;
    // Virtual Address del codigo
    vaddr_t code_virt = TASK_CODE_VIRTUAL;
    // Kernel Stack
    vaddr_t stack0 = mmu_next_free_kernel_page();
    // Stack Pointer del Kernel
    vaddr_t esp0 = stack0 + PAGE_SIZE;
    /*
    tss_tasks[task_id].cr3 = cr3;
    tss_tasks[task_id].esp = stack;
    tss_tasks[task_id].ebp = stack;
    tss_tasks[task_id].eip = code_virt;
    tss_tasks[task_id].cs = GDT_CODE_3_SEL;
    tss_tasks[task_id].ds = GDT_DATA_3_SEL;
    tss_tasks[task_id].es = GDT_DATA_3_SEL;
    tss_tasks[task_id].fs = GDT_DATA_3_SEL;
    tss_tasks[task_id].gs = GDT_DATA_3_SEL;
    tss_tasks[task_id].ss = GDT_DATA_3_SEL;
    tss_tasks[task_id].ss0 = GDT_DATA_0_SEL;
    tss_tasks[task_id].esp0 = esp0;
    tss_tasks[task_id].eflags = EFLAGS_IF;
    */
    return (tss_t) {
        .cr3 = cr3,
        .esp = stack,
        .ebp = stack,
        .eip = code_virt,
        .cs = GDT_CODE_3_SEL,
        .ds = GDT_DATA_3_SEL,
        .es = GDT_DATA_3_SEL,
        .fs = GDT_DATA_3_SEL,
        .gs = GDT_DATA_3_SEL,
        .ss = GDT_DATA_3_SEL,
        .ss0 = GDT_DATA_0_SEL,
        .esp0 = esp0,
        .eflags = EFLAGS_IF,
    };
}

/**
 * Inicializa las primeras entradas de tss (inicial y idle)
 */
void tss_init(void) {
    //tss_gdt_entry_for_task(GDT_IDX_TASK_INITIAL, &tss_initial);
    //tss_gdt_entry_for_task(GDT_IDX_TASK_IDLE, &tss_idle);
    //uint32_t debug = GDT_TASK_A_SEL;
    gdt[GDT_IDX_TASK_INITIAL] = tss_gdt_entry_for_task(&tss_initial);
    gdt[GDT_IDX_TASK_IDLE] = tss_gdt_entry_for_task(&tss_idle);
}

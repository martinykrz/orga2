#include <stdio.h>
#include <stdlib.h>

#include "stack.h"
#include "student.h"
#include "teacher.h"

stack_t *stack;

int main()
{
    stack = createStack(100);

    student_t stud1 = {
        .name = "Steve Balmer",
        .dni = 12345678,
        .califications = {3,2,1},
        .concept = -2,
    };

    studentp_t stud2 = {
        .name = "Linus Torvalds",
        .dni = 23456789,
        .califications = {9,7,8},
        .concept = 1,
    };

    student_t *st1p = &stud1;
    studentp_t *st2p = &stud2;

    (*stack->push)(stack, (uint64_t)st1p);
    (*stack->push)(stack, (uint64_t)st2p);

    // Una "lista" de profesores:
    teacher_t *teachers = malloc(3*sizeof(teacher_t));
    
    (*stack->push)(stack, (uint64_t)teachers);

    teachers[0].name = "Alejandro Furfaro";
    printf("Nombre del profesor: %s\n", ((teacher_t *) stack->top(stack))[0].name);
    (*stack->pop)(stack);

    printStudent((student_t *) stack->pop(stack));
    printf("---------------------------------------\n");
    printStudentp((studentp_t *) stack->pop(stack));

    return 0;
}

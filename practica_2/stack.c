#include "stack.h"
#include <stdlib.h>

/* Desapila el último elemento (i.e. lo devuelve y lo elimina de la pila)
*/
uint64_t pop(stack_t *stack)
{
    uint64_t data = *stack->esp;
    *stack->esp = 0;
    stack->esp -= 1;
    return data;
}

/* Devuelve el contenido del tope de la pila (y lo mantiene).
*/
uint64_t top(stack_t *stack)
{
    return *stack->esp;
}

/* Apila el contenido de 'data'
*/
void push(stack_t *stack, uint64_t data)
{
    stack->esp += 1;
    *stack->esp = data;
}

stack_t * createStack(size_t size)
{
    stack_t* stack = malloc(size * sizeof(stack_t));
    stack->_stackMem = (uint64_t*)stack;

    stack->ebp = stack->_stackMem + size - 1;  // La base del stack es la dirección numéricamente más grande.
    stack->esp = stack->ebp;  // Al comienzo, la base y el tope coinciden

    stack->pop = pop;
    stack->top = top;
    stack->push = push;

    return stack;
}

void deleteStack(stack_t *stack)
{
   free(stack); 
}

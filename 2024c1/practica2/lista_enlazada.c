#include "lista_enlazada.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

lista_t* nueva_lista(void) {
    lista_t* lista = malloc(sizeof(lista_t));
    lista->head = NULL;
    return lista;
}

uint32_t longitud(lista_t* lista) {
    uint32_t len = 0;
    nodo_t* actual = lista->head;
    while (actual != NULL) {
        len += 1;
        actual = actual->next;  
    }

    return len;
}

void agregar_al_final(lista_t* lista, uint32_t* arreglo, uint64_t longitud) {
    uint32_t* copiaArreglo = malloc(longitud*sizeof(*arreglo));
    for (uint64_t i = 0; i < longitud; i++) {
        copiaArreglo[i] = arreglo[i];
    }
    
    nodo_t* nuevoNodo = malloc(sizeof(nodo_t));
    nuevoNodo->longitud = longitud;
    nuevoNodo->arreglo = copiaArreglo;
    nuevoNodo->next = NULL;
    
    if(lista->head != NULL) {
        nodo_t* ultimoNodo = lista->head;
        while (ultimoNodo->next != NULL) {
            ultimoNodo = ultimoNodo->next;
        }
        ultimoNodo->next = nuevoNodo;
    } else {
        lista->head = nuevoNodo;
    }
}

nodo_t* iesimo(lista_t* lista, uint32_t i) {
    nodo_t* actual = lista->head;
    for(uint32_t j = 0; j < i && actual != NULL; j++) {
        if (actual != NULL) {
            actual = actual->next;
        } else {
            actual = NULL;
        }
    }

    return actual;
}

uint64_t cantidad_total_de_elementos(lista_t* lista) {
    uint64_t total = 0;
    nodo_t* actual = lista->head;
    while(actual != NULL) {
        total += actual->longitud;
        actual = actual->next;
    }
    return total;
}

void imprimir_lista(lista_t* lista) {
    nodo_t* actual = lista->head;
    for (uint32_t i = 0; i < longitud(lista); i++) {
        printf("| %zu | ->", actual->longitud); 
    }
    
    printf("null");
}

// Función auxiliar para lista_contiene_elemento
int array_contiene_elemento(uint32_t* array, uint64_t size_of_array, uint32_t elemento_a_buscar) {
    int res = 0;
    uint64_t i = 0;
    while (i < size_of_array && res == 0) {
        if(array[i] == elemento_a_buscar) {
            res = 1;
        }
        i += 1;
    }
    return res;
}

int lista_contiene_elemento(lista_t* lista, uint32_t elemento_a_buscar) {
    int res = 0;
    nodo_t* actual = lista->head;

    while(actual != NULL && res == 0) {
        res = array_contiene_elemento(actual->arreglo, actual->longitud, elemento_a_buscar);
        actual = actual->next;
    }

    return res;
}

// Devuelve la memoria otorgada para construir la lista indicada por el primer argumento.
// Tener en cuenta que ademas, se debe liberar la memoria correspondiente a cada array de cada elemento de la lista.
void destruir_lista(lista_t* lista) {
    nodo_t* actual = lista->head;
    nodo_t* sig;

    while(actual != NULL) {
        sig = actual->next;
        free(actual->arreglo);
        free(actual);
        actual = sig;
    }

    free(lista);
}

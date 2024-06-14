#include "vector.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

vector_t* nuevo_vector(void) {
    vector_t* vector = malloc(sizeof(vector_t));
    vector->size = 0;
    vector->capacity = 2;
    uint32_t* vec_array = malloc(vector->capacity*sizeof(uint32_t));
    vector->array = vec_array;

    return vector;
}

uint64_t get_size(vector_t* vector) {
    uint64_t res = vector->size;

    return res;
}

void push_back(vector_t* vector, uint32_t elemento) {
    if ((vector->capacity - vector->size) <= 0) {
        //vector->array = realloc(vector->array, (vector->capacity + 1)*sizeof(uint32_t));
        vector->array = realloc(vector->array, (2*vector->capacity)*sizeof(uint32_t));
        vector->capacity = 2*vector->capacity;
    }
    vector->array[get_size(vector)] = elemento;
    vector->size += 1;  
}

int son_iguales(vector_t* v1, vector_t* v2) {
    int res = 1;
    if (v1->size == v2->size) {
        for(uint64_t i = 0; i < v1->size; i++) {
            if (v1->array[i] != v2->array[i]) {
                res = 0;
            }
        }
    } else {
        res = 0;
    }
    
    return res;
}

uint32_t iesimo(vector_t* vector, size_t index) {
    uint32_t res = 0;
    if (index < get_size(vector)) {
        res = vector->array[index];
    }

    return res;
}

void copiar_iesimo(vector_t* vector, size_t index, uint32_t* out) {
    *out = iesimo(vector, index);
}

// Dado un array de vectores, devuelve un puntero a aquel con mayor longitud.
vector_t* vector_mas_grande(vector_t** array_de_vectores, size_t longitud_del_array) {
    vector_t* largest = array_de_vectores[0];
    size_t i = 1;
    while(i < longitud_del_array) {
        if (get_size(largest) < get_size(array_de_vectores[i])) {
            largest = array_de_vectores[i];
        } 
        i++;
    }
    if (get_size(largest) == 0) {
        largest = NULL;
    }

    return largest;
}

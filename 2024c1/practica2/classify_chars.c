#include "classify_chars.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longitud_de_string(char* string) {
    int len = 0;
    // int i = 0;
    if (string != NULL) {
        while (string[len] != '\0') {
            len += 1;
        }
    }
    return len;
}

int perteneceA(char* string, char letra) {
    int res = 0;
    for (int i = 0; string[i] != '\0'; i++) {
        if (letra == string[i]) {
            res = 1;
            break;
        }
    }
    return res;
}

void classify_chars_in_string(char* string, char** vowels_and_cons) {

    char* vocales = "AEIOUaeiou"; // Este string va a servir para chequear si un char es o no vocal (no se si distingue mayus)
    size_t ivow = 0; //indice que delimita cantidad de elementos en vowels
    size_t icons = 0; // "     "      "       "     "      "     en cons

    for(int i = 0; i < longitud_de_string(string); i++) {
        if (perteneceA(vocales, string[i])) {
            vowels_and_cons[0][ivow] = string[i];
            ivow++;
        } else {
            vowels_and_cons[1][icons] = string[i];
            icons++;
        }
    }
}

void classify_chars(classifier_t* array, uint64_t size_of_array) {
    for (uint64_t i = 0; i < size_of_array; i++) {
        array[i].vowels_and_consonants = malloc(2 * sizeof(char*));
        array[i].vowels_and_consonants[0] = malloc(64 * sizeof(char));
        memset(array[i].vowels_and_consonants[0], 0, 64);
        array[i].vowels_and_consonants[1] = malloc(64 * sizeof(char));
        memset(array[i].vowels_and_consonants[1], 0, 64);
        classify_chars_in_string(array[i].string, array[i].vowels_and_consonants);
    }
}

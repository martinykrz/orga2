#include "contar_espacios.h"
#include <stdio.h>

uint32_t longitud_de_string(char* string) {
    uint32_t len = 0;
    if (string != NULL) {
        while (string[len] != '\0') {
            len += 1;
        }
    }
    return len;
}

uint32_t contar_espacios(char* string) {
    uint32_t espacios = 0;
    for (uint32_t i=0; i < longitud_de_string(string); i++) {
        if (string[i] == ' ') {
            espacios += 1;
        }
    }
    return espacios;
}

// Pueden probar acá su código (recuerden comentarlo antes de ejecutar los tests!)
/*
int main() {

    printf("1. %d\n", contar_espacios("hola como andas?"));

    printf("2. %d\n", contar_espacios("holaaaa orga2"));
}
*/

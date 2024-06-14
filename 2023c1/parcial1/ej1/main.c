#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

#define ARRAY_SIZE 100
#define NUM_ARRAYS 50

uint32_t shuffle_int(uint32_t min, uint32_t max){
	return (uint32_t) (rand() % (max + 1)) + min;
}

int main (void){
	/* Acá pueden realizar sus propias pruebas */
    for (int i=0; i < NUM_ARRAYS; ++i) {
        templo* arrayTemplos = malloc(ARRAY_SIZE * sizeof(templo));
        uint32_t clasico = 0;
	    for (int j=0; j < ARRAY_SIZE; ++j) {
	        arrayTemplos[j].colum_corto = shuffle_int(1,1024);
	        if (shuffle_int(0,1)) {
                uint32_t debug_largo = 2 * arrayTemplos[j].colum_corto + 1;
                arrayTemplos[j].colum_largo = debug_largo;
                if (debug_largo <= 256) {
                    clasico++;
                }
            } else {
                arrayTemplos[j].colum_largo = shuffle_int(1,2048);
            }
            /* printf("Valores %d -> Corto: %d, Largo: %d => %d\n", i, arrayTemplos[j].colum_corto, arrayTemplos[j].colum_largo, clasico); */
        }
        printf("Clasicos %d -> %d\n", i, cuantosTemplosClasicos(arrayTemplos, ARRAY_SIZE));
        free(arrayTemplos);
	}
	return 0;    
}

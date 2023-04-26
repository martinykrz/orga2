#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"

#define ARR_LENGTH  4
#define ROLL_LENGTH 16

static uint32_t x[ROLL_LENGTH];
static double   f[ROLL_LENGTH];

void shuffle(uint32_t max){
	for (int i = 0; i < ROLL_LENGTH; i++) {
		x[i] = (uint32_t) rand() % max;
	}
}

uint32_t shuffle_int(uint32_t min, uint32_t max){
		return (uint32_t) (rand() % max) + min;
}

int main (void){
	/* Acá pueden realizar sus propias pruebas */
    for (int i=0; i < 100; i++) {
        uint8_t* bytes = (uint8_t*) malloc(16);
        shuffle(256);
        uint8_t m = shuffle_int(0,16);
        uint8_t n = shuffle_int(0,16);
        printf("%d: (%d, %d)\n", i, n, m);
        printf("[");
        for (int j=0; j < 16; j++){
            bytes[j] = x[j];
            printf("%d, ", x[j]);
        }
        printf("]\n");
        invertirBytes_asm(bytes, n, m);
        printf("[");
        for (int k=0; k < 16; k++){
            printf("%d, ", bytes[k]);
        }
        printf("]\n");
        free(bytes);    
    }
    return 0;
}

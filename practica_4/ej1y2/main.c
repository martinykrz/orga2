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
    /* for (int i=0; i < 5; i++) { */
        /* uint32_t array_size = shuffle_int(1,20); */
        uint32_t array_size = 1;
        data_t* test_data = (data_t*) malloc(sizeof(data_t)*array_size);
        /* for(uint32_t j = 0; j < array_size; j++){ */
            shuffle(16);
            printf("x(%d): ", 0);
            for (int i=0 ; i < ROLL_LENGTH; i++) {
                printf("%d, ", x[i]);
            }
            printf("\n");
            for (int k = 0; k < 8; k++){
                test_data[0].a[k] = x[k];
                test_data[0].b[k] = x[k+8];
                test_data[0].c[k] = ((uint32_t) test_data[0].a[k] + (uint32_t) test_data[0].b[k])*8;
            }
        /* } */
        printf("asm -> %d\n", checksum_asm(test_data, array_size));
        printf("c -> %d\n", checksum_c(test_data, array_size));
        free(test_data);
    /* } */
    return 0;
}

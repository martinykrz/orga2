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
        uint32_t array_size = shuffle_int(1,20);
        data_t* test_data = (data_t*) malloc(sizeof(data_t)*array_size);
        for(uint32_t j = 0; j < array_size; j++){
            shuffle(1000);
            for (int k = 0; k < 8; k++){
                test_data[j].a[k] = x[k];
                test_data[j].b[k] = x[k+8];
                /* uint32_t value = shuffle_int(5,10); */
                uint32_t value = 8;
                test_data[j].c[k] = ((uint32_t) test_data[j].a[k] + (uint32_t) test_data[j].b[k])*value;
            }
        }
        uint32_t asm_ = checksum_asm(test_data, array_size);
        uint32_t c_ = checksum_c(test_data, array_size);
        if (asm_ != c_) {
            printf("%d -> asm: %d, c: %d\n", i, asm_, c_);
            printf("Datos: array_size -> %d\n", array_size);
            for(uint32_t j = 0; j < array_size; j++){
                for (int k = 0; k < 8; k++){
                    uint16_t suma = test_data[j].a[k]+test_data[j].b[k];
                    printf("%d -> a: %-8d b: %-8d c: %-8dres: %d\n", k, test_data[j].a[k], test_data[j].b[k], test_data[j].c[k], suma*8);
                }
                printf("---------------------\n");
            }
        }
        free(test_data);
    }
    return 0;
}

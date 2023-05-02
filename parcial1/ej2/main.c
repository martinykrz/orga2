#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej2.h"

#define N 4

static uint32_t a[N][N];
static uint32_t b[N][N];
static uint32_t c[N][N];

void shuffle(uint32_t max){
	for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++){
		    a[i][j] = (uint32_t) rand() % max;
            b[i][j] = (uint32_t) rand() % max;
            if ( j % 2 == 0){
                c[i][j] = a[i][j];
            }else{
                c[i][j] = b[i][j];
            }
        }
	}
}

uint32_t shuffle_int(uint32_t min, uint32_t max){
	return (uint32_t) (rand() % (max + 1)) + min;
}

int main (void){
	/* Acá pueden realizar sus propias pruebas */
	shuffle(10);
	uint8_t *result = malloc(N*N);
    miraQueCoincidencia((uint8_t*)a,(uint8_t*)a,N,result);

    for(int i=0;i<N;++i){
        for(int j=0;j<N;++j){
            printf("%3d ",result[i*N +j]);
		}
    }
	printf("\n");
	return 0;    
}



#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"

int main (void){
	// Acá pueden realizar sus propias pruebas 
    FILE* fp;
    fp = fopen("hello.txt", "w");
    if (fp == NULL) {
        return 1;
    }
    strPrint("%s", fp);
    /* fprintf(fp, "%s", "Hello, World!\n"); */
    fclose(fp);
    return 0;    
}



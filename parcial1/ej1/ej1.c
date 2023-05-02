#include "ej1.h"

uint32_t cuantosTemplosClasicos_c(templo *temploArr, size_t temploArr_len){
    uint32_t res = 0;
    for (size_t i=0; i < temploArr_len; i++) {
        if (2 * temploArr[i].colum_corto + 1 == temploArr[i].colum_largo) {
            res++;
        }
    }
    return res;
}
  
templo* templosClasicos_c(templo *temploArr, size_t temploArr_len){
    uint32_t cant_clasicos = cuantosTemplosClasicos(temploArr, temploArr_len);
    templo* clasicos = malloc(cant_clasicos * sizeof(templo));
    size_t count = 0;
    for (size_t i=0; i < temploArr_len; i++) {
        if (2 * temploArr[i].colum_corto + 1 == temploArr[i].colum_largo) {
            clasicos[count] = temploArr[i];
            count++;
        }
    }
    return clasicos;
}

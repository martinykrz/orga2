#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

char* cesar(char* s, uint8_t n) {
    int i=0;
    while (s[i] != '\0') {
        i++;
    }
    char* res = malloc((i+1)*sizeof(char));
    for (int j=0; j < i; j++) {
        res[j] = (char)((uint8_t)s[j] + (n % 26));
    }
    return res;
}

int main() {
    char* t1 = "CASA"; //String constante
    char* t2 = "CALABAZA";
    char* res1 = cesar(t1, 3);
    char* res2 = cesar(t2, 7);
    printf("%s => %s\n", t1, res1);
    printf("%s => %s\n", t2, res2);
    free(res2);
    free(res1);
    return 0;
}

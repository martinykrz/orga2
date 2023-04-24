#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

char* cesar(char* s, uint8_t n) {
    int i=0;
    while (s[i] != '\0') {
        uint8_t u = (uint8_t)s[i] + (n % 26);
        char c = (char)u;
        s[i] = c;
        i++;
    }
    return s;
}

int main() {
    char* t1 = "CASA";
    char* t2 = "CALABAZA";
    printf("%s => %s\n", t1, cesar(t1, 3));
    printf("%s => %s\n", t2, cesar(t2, 7));
    return 0;
}

#include <stdio.h>
#include <stdlib.h>

void prefijo_de(char* s, char* t) {
    int i=0;
    while (s[i] == t[i] && (s[i] != '\0' || t[i] != '\0')) {
        i++;
    }
    char* res = malloc(i*sizeof(char*));
    for (int j=0; j < i; j++) {
        res[j] = s[j];
    }
    printf("%d (\"%s\")\n", i, res);
    free(res);
}

int main() {
    prefijo_de("Astronomia", "Astrologia");
    prefijo_de("Pinchado", "Pincel");
    prefijo_de("Boca", "River");
    prefijo_de("ABCD", "ABCD");
    return 0;
}

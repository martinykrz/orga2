#include "ejercicio6_asm.h"

int main() {
    char* s = "CALABAZA";
    char* res = cesar(s, 7);
    printf("%s => %s\n", s, res);
    clean(res);
    return 0;
}

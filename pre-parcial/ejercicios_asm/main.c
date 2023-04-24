#include "cesar.h"

int main() {
    char* s = "CASA";
    char* res = cesar(s, 3);
    printf("%s => %s\n", s, res);
    return 0;
}

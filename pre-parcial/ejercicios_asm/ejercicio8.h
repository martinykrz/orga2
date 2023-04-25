#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define NAME_LEN 21

typedef struct cliente_str {
    char nombre[NAME_LEN];
    char apellido[NAME_LEN];
    uint64_t compra;
    uint32_t dni;
} cliente_t;

typedef struct __attribute__((__packed__)) packed_cliente_str {
    char nombre[NAME_LEN];
    char apellido[NAME_LEN];
    uint64_t compra;
    uint32_t dni;
} __attribute__((__packed__)) packed_cliente_t;

void check_cliente_t(cliente_t c);
void check_packed_cliente_t(packed_cliente_t c);

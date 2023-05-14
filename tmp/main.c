#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <libgen.h>

#include "simd.h"
#include "utils.h"
#include "imagenes.h"

extern filtro_t Offset;
extern filtro_t Sharpen;

filtro_t filtros[2];

int main() {
    filtros[0] = Offset;
    filtros[1] = Sharpen;

    configuracion_t config;
    config.archivo_entrada = "img/paisaje.bmp";
    config.archivo_entrada_2 = NULL;
    config.dst.width = 0;
    config.bits_src = 32;
    config.bits_dst = 32;
    config.es_video = false;
    config.verbose = false;
    config.frames = false;
    config.nombre = false;
    config.cant_iteraciones = 5;
    config.carpeta_salida = ".";
    config.extra_archivo_salida = "";
    config.tipo_filtro = 1;

    filtro_t *filtro = &filtros[0]; // 0->Offset, 1->Sharpen
    correr_filtro_imagen(&config, filtro->aplicador);
    // filtro->liberar(&config);

    return 0;
}

void correr_filtro_imagen(configuracion_t* config, aplicador_fn_t aplicador) {
    imagenes_abrir(config);

    imagenes_flipVertical(&config->src, src_img);
    imagenes_flipVertical(&config->src, dst_img);

    for (int i=0; i < config->cant_iteraciones; i++) {
        aplicador(config);
    }

    imagenes_flipVertical(&config->dst, dst_img);
    imagenes_flipVertical(&config->dst, dst_img);

    imagenes_guardar(config);
    imagenes_liberar();
}

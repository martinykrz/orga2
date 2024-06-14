# Pasaje a Modo Protegido

## Definiendo la GDT

1. A que nos referimos con modo real y con modo protegido en un procesador Intel? Que particularidades tiene cada modo?
    - Modo Real
        + Es un modo que simula un ambiente similar al de un procesador Intel 8086
        + Trabaja unicamente en el mayor nivel de privilegio (el menor numerico)
        + Direcciona 1 MB de memoria
        + Trabaja en 16 bits
        + Usa unicamente segemetacion
    - Modo Protegido
        + Es el modo nativo del procesador
        + Trabaja en varios niveles de privilegio
        + Direcciona 4 GB en memoria
        + Trabaja en 32 y 64 bits
        + Habilita la paginacion

2. Porque debemos hacer el pasaje de modo real a modo protegido? No podriamos simplemente tener un sistema operativo en modo real? Que desventajas tendria?
    - Debemos hacer el pasaje de modo real a modo protegido ya que, en el modo real, solamente se puede direccionar 1 MB de memoria con segmentacion, lo que complica a un sistema operativo la administracion de la misma y trabajar unicamente con el mayor nivel de privilegio (el menor numerico), lo hace bastante inseguro en caso de un ataque malicioso

3. Que es la GDT? Como es el formato de un descriptor de segmento, bit a bit?
    - La GDT (Global Descriptor Table), es una tabla donde se encuentran los descriptores de segmentos que, junto con la direccion logica, se calcula la direccion lineal para acceder a memoria
    <!-- - TODO: Descriptor de segmento -->

4. Que combinacion de bits tendriamos que usar si queremos especificar un segmento para ejecucion y lectura de codigo?
    - bit 11 (S) = 1
    - bit 10 (E/C) = 0
    - bit 9 (W/R) = 1
    - bit 8 (A) = 0


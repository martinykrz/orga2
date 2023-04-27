# Orga 2 CheatSheet

## Assembly

### Formato ELF
Secciones del codigo assembly
* ```.data``` -> Variables globales inicializadas (db, dw, dd, dq)
* ```.rodata``` -> Constantes globales inicializadas (db, dw, dd, dq)
* ```.bss``` -> Variables globales no inicializadas (resb, resw, resd, resq)
* ```.text``` -> Codigo
* ```global``` -> Exporta la funcion
* ```_start``` -> Main de assembly

### Hacer ejecutable
1. Ensamblar -> ```nasm -f elf64 -g -F DWARF example.asm```
2. Linkear -> ```ld -o main example.o```
3. Ejecutar -> ```./main```

### Registros
| Type | Registers (IA-32) | Registers (x64) |
| :--: | :---------------: | :-------------: |
| Byte (8-bits) | AL, BL, CL, DL, AH, BH, CH, DH | AL, BL, CL, DL, DIL, SIL, BPL, SPL, R8B-R15B |
| Word (16-bits) | AX, BX, CX, DX, SI, BP, SP | AX, BX, CX, DX, DI, SI, BP, SP, R8W-R15W |
| DoubleWord (32-bits) | EAX, EBX, ECX, EDX, EDI, ESI, EBP, ESP | EAX, EBX, ECX, EDX, EDI, ESI, EBP, ESP, R8D-R15D |
| QuadWord (64-bits) | - | RAX, RBX, RCX, RDX, RDI, RSI, RBP, RSP, R8-R15 |

### Acceso a memoria
```[Base + (Index x Scale) + Displacement]```
| Base | Index | Scale | Displacement |
| :--: | :---: | :---: | :----------: |
| RAX  |  RAX  |   1   | Cte. 32 bits |
| ...  |  ...  |   2   |              |
| R15  |  R15  |   4   |              |
|      | No RSP |  8   |              |

## C/ASM

### Tipos de datos
* Atomicos
    - ```bool``` -> 1 byte
    - ```char``` -> 1 byte
    - ```short``` -> 2 bytes
    - ```int``` -> 4 bytes
    - ```long``` -> 8 bytes
    - ```float``` -> Depende
* Arreglos
    - ```type_t arr[N]``` -> ```N * sizeof(type_t)```
* Punteros
    - ```type_t *``` -> ```sizeof(type_t\*)```

### Alineacion de datos

#### Definiciones
* Dato ```x``` alineado a ```n``` bytes -> posicion multiplo de ```n```
* Tamaño de ```x``` alineado a ```n``` bytes -> ```sizeof(x)``` multiplo de ```n```

#### Datos alineados
* La alineacion de una estructura es la del atributo que requiere mas alineacion
    - Si el atributo que mas alineacion necesita esta alineado a 4 bytes, la estructura debe ubicarse en una direccion multiplo de cuatro
* El tamaño de una estructura debe de ser multiplo de su alineacion
* Cada atributo primitivo esta alineado segun su tamaño

#### Datos empaquetado (packed)
* El tamaño de la estructura es la suma del tamaño de los atributos
* Los atributos se encuentran contiguos en memoria

#### Padding
Espacios vacios (con ceros o basura) entre los atributos para respetar la alineacion de los mismos, y tambien va a dejar espacio al final de una estructura si hace falta

### Heap
* ```type_t* t = malloc(byte)``` -> Da un puntero que apunta a la base del espacio de memoria asignado
* ```free(t)``` -> Libera dicha memoria

### Convencion de llamada
| 64 bits | Convencion |
| :-----: | :--------: |
| No volatiles | RBX, RBP, R12, R13, R14, R15 |
| Valor de retorno | RAX (enteros/punturos), XMM0 (flotantes) |
| Entero, puntero | RDI, RSI, RDX, RCX, R8, R9 (->) |
| Flotantes | XMM0, ..., XMM7 (->) |
| No registros? | PUSH a la pila (<-) |
| Stack/Pila | Todo PUSH/SUB debe tener POP/ADD |
| Call func C | Pila alineada a 16 bytes (```sub rsp, x```)|

| 32 bits | Convencion |
| :-----: | :--------: |
| No volatiles | EBX, EBP, ESI, EDI |
| Valor de retorno | EAX |
| Parametros | PUSH a la pila (<-) |
| Stack/Pila | Todo PUSH/SUB debe tener POP/ADD |
| Call func C | Pila alineada a 16 bytes (```sub rsp, x```)|

### Prologo 
Es donde se reserva espacio en la pila para datos temporales, se agrega padding para mantenerla alineada a 16 bytes y se preserva los valores de los registros no volatiles
```asm
push rbp ; Comienza alineada
mov rbp, rsp
push reg ; Se desalinea a 8
...
```

### Epilogo
Es donde restauramos los valores de los registros no volatiles y devolcemos la pila a su estado inicial
```asm
...
pop reg
pop rbp
ret
```

### Stack Frame
Region de la pila comprendida entre los parametros recibidos y el tope de la pila actual
<!-- TODO: Ver foto pila, hacer un ejemplo -->

### SIMD
* [Load/Store](simd/load_store.md)
* [Aritmeticas](simd/aritmeticas.md)
* [Logicas](simd/logicas.md)
* [Comparacion](simd/comparacion.md)
* [Empaquetado](simd/empaquetado.md)
* [Desempaquetado](simd/desempaquetado.md)
* [Shuffles](simd/shuffle.md)
* [Insert/Extract](simd/insert_extract.md)
* [Blend](simd/blend.md)
* [Conversion](simd/conversion.md)

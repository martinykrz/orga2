# Enunciado 1

## Arquitectura basica IA-32 e Intel 64

### Ejercicio 1

#### IA-32 Entorno de ejecucion

* Cual es el tamaño en bits de una direccion de memoria en la arquitectura IA-32 y cual es la unidad mas pequeña que podemos direccionar?
    - Tiene una direccion de memoria de 32 bits
    - La unidad mas pequeña que podemos direccionar es de 1 byte => 8 bits

* Cual registros de proposito general hay en IA-32 y que tamaño tienen?
    - Los registros de proposito general son 8 y son de 32 bits
    - EAX, EBX, ECX, EDX, ESI, EDI, EBP, ESP

* Busquen en el manual que guarda el registro EIP (Instruction Pointer) e indiquen su tamaño. Por que motivo creen que el EIP tiene ese tamaño en bits?
    - El EIP guarda el offset del segmeto de codigo que esta corriendo para la proxima instruccion a hacer ejecutada. Su tamaño es de 32 bits
    - El tamaño se debe a que guarda una direccion de memoria y las direcciones son de 32 bits

### Ejercicio 2

#### Flags

* Busquen en la seccion del manual que guarda el registro EFLAGS e indiquen su tamaño en bits
    - El registro EFLAGS contiene un grupo de status flags, control flags y system flags y el tamaño es de 32 bits

* En el formato del registro, busquen los siguientes bits e indiquen para que son y en que posicion del registro estan almacenados
    - Flag Overflow (bit 11)
        + Se prende cuando el resultado positivo es muy grande o el resultado negativo es muy chico para que entre al destino. Indica que hay overflow en integrales con signo (complemento a dos)
    - Flag Signo (bit 7)
        + Es igual al bit mas significativo que indica el signo del numero
    - Flag Interrupciones (bit 9)
        + Indica cuando se puede atender la interrupcion del sistema

* Indique si la arquitectura Intel 64 se usa el mismo registro. En caso que sea otro, indiquen su tamaño y la relacion tendria con el de IA-32
    - Usa un registro de 64 bits llamado RFLAGS y la parte alta esta reservada y la parte baja es lo mismo que el EFLAGS

### Ejercicio 3

#### Stack y llamadas a funcion

* Para que es necesaria la pila y donde esta ubicada?
    - La pila es necesaria para soportar rutinas y subrutinas, y el pasaje de parametros entre procedimientos o subrutinas
    - Esta ubicada en memoria

* Para que sirven los registros ESP y EBP? Que consideraciones debemos tener al trabajar con cada uno de ellos?
    - ESP
        + Sirve para almacenar la direccion de memoria de instruccion proxima a ejecutar
        + Siempre tiene que apuntar al tope de la pila
        + La direccion se modifica sacando (`pop`) o agregando (`push`) valores a la pila
    - EBP
        + Sirve para almacenar la direccion de memoria donde termina la seccion de pila 

* Que registro se pushea en la pila al hacer un CALL?
    - Al hacer un CALL, se pushea la direccion de memoria en el EIP a la pila

* Que ocurre al hacer un RET?
    - Al hacer un RET, saca la direccion de memoria de la pila y la coloca en el EIP

* Que debe asegurarse el programador antes de llamar a un RET cuando esta escribiendo una subrutina? Como lo asegura?
    - Debe asegurarse de tener a mano la locacion del ESP, guardandolo dentre de un registro de proposito general

* Cual es el ancho de pila en modo 32 bits y en 64 bits?
    - En 32 bits, el ancho puede ser de 16 o 32 bits y en 64 bits, es de 64 bits

* El EBP podria ser usado para guardar datos que no sean la base de la pila?
    - Si no usa la pila, el EBP se lo puede manipular como cualquier registro de proposito general. En caso contrario, es indispensable que guarde la base de la pila

## Set de Instrucciones IA-32 e Intel 64

### Ejercicio 4

#### Set de instrucciones

| Instruccion | Operando 1 | Operando 2 | Definicion | Notas |
| :---------: | :--------: | :--------: | :--------: | :---: |
| `dec` | `r/m8`, `r/m16`, `r/m32`, `r/m64` | - | Substrata 1 el valor dentro del registro o de una direccion de memoria | - |
| `add` | `r/m8`, `r/m16`, `r/m32`, `r/m64` | `r/m8`, `r/m16`, `r/m32`, `r/m64`, `imm8`, `imm16`, `imm32` | Suma el valor del primero operando con el segundo y el resultado lo guarda en el primero | No puede haber dos direcciones de memoria como operandos |
| `mov` | `r/m8`, `r/m16`, `r/m32`, `r/m64` | `r/m8`, `r/m16`, `r/m32`, `r/m64`, `imm8`, `imm16`, `imm32` | Copia el segundo operando en el primero | Ambos operandos tienen que ser del mismo tamaño |
| `jz` | `rel8`, `rel16`, `rel32` | - | Salta hacia la direccion relativa si el valor comparado es igual a cero (`ZF = 1`)| - |
| `je` | `rel8`, `rel16`, `rel32` | - | Salta hacia la direccion relativa si dos valores, al compararlos, son iguales | Su resta es igual a cero (`ZF = 1`) |

#### Ejemplos

```asm
dec rax
dec eax
dec al

add rcx, 0xa
add rdx, rax
add [0xff43], [0xae32] ; este es un ejemplo de una instruccion imposible

mov rax, rcx
mov ebx, 32826
mov rax, ebx ; este es un ejemplo de una instruccion imposible
```

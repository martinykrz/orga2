# Programacion Assembly x86 - Convencion C

## Conceptos generales

* Que entienden por convencion de llamada? Como esta definida en la ABI de System V para 64 y 32 bits?
    - Una convencion de llamada se entiende como la forma de enviar y recibir informacion usando funciones del sistema o del usuario
    - Para 64 bits, esta definida para que se usen los registros de proposito general y la pila
    - Para 32 bits, esta definida para que solo se pueda utilizar la pila

* Quien toma la responsabilidad de asegurar que se cumple la convencion de llamada en C? Quien toma la responsabilidad de asegurar que se cumple la convencion de llamada en ASM?
    - En C se encarga el compilador/linker y en ASM se encarga el programador

* Que es un stack frame? A que se le suele decir **prologo y epilogo**?
    - El stack frame es donde restauramos los valores de los registros no volatiles y devolcemos la pila a su estado inicial
    - El prologo es donde se reserva espacio en la pila para datos temporales, se agrega padding para mantenerla alineada a 16 bytes y se preserva los valores de los registros no volatiles
    - El epilogo es donde restauramos los valores de los registros no volatiles y devolcemos la pila a su estado inicialEs donde restauramos los valores de los registros no volatiles y devolcemos la pila a su estado inicial

* Cual es el mecanismo utilizado para almacenar variables temporales?
    - El mecanismo utilizado para almacenar variables temporales es guardarlos en la pila (?)

* A cuantos bytes es necesario alinear la pila si utilizamos funciones de `libc`? Si la pila esta alineada a 16 bytes al realizarse una llamada funcion, cual va a ser su alineamiento al ejecutar la primera instruccion de la funcion llamada?
    - Si utilizamos funciones de `libc`, la pila tiene que estar alineada a 16 bytes
    - El alineamiento al ejecutar la primera instruccion de la funcion llamada estaria a 8 bytes

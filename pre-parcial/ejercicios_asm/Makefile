CC=cc
CFLAGS=-std=c11 -Wall -Wextra -pedantic -O0 -g -lm -Wno-unused-variable -Wno-unused-parameter 
NASM=nasm
NASMFLAGS=-f elf64 -g -F DWARF

all: main1 main2 main3 main4 main5 main6c main6asm main7

main1: ejercicio1.o
	ld -o $@ $<

ejercicio1.o: ejercicio1.asm
	$(NASM) $(NASMFLAGS) $< -o $@

main2: ejercicio2.o
	ld -o $@ $<

ejercicio2.o: ejercicio2.asm
	$(NASM) $(NASMFLAGS) $< -o $@

main3: ejercicio3.o
	ld -o $@ $<

ejercicio3.o: ejercicio3.asm
	$(NASM) $(NASMFLAGS) $< -o $@

main4: ejercicio4.o
	ld -o $@ $<

ejercicio4.o: ejercicio4.asm
	$(NASM) $(NASMFLAGS) $< -o $@

main5: ejercicio5.o
	ld -o $@ $<

ejercicio5.o: ejercicio5.asm
	$(NASM) $(NASMFLAGS) $< -o $@

main6c: ejercicio6_c.o
	$(CC) $(CFLAGS) $^ -o $@

ejercicio6_c.o: ejercicio6_c.c 
	$(CC) $(CFLAGS) -c $^ -o $@

main6asm: ejercicio6_asm.o cesar.o
	$(CC) $(CFLAGS) $^ -o $@

cesar.o: cesar.asm
	$(NASM) $(NASMFLAGS) $< -o $@

ejercicio6_asm.o: ejercicio6_asm.c ejercicio6_asm.h
	$(CC) $(CFLAGS) -c $< -o $@

main7: ejercicio7.o
	$(CC) $(CFLAGS) $^ -o $@

ejercicio7.o: ejercicio7.c
	$(CC) $(CFLAGS) -c $^ -o $@

clean:
	rm -f main*
	rm -f *.o

NASM := nasm
NASMFLAGS := -Wall -f elf64 -g -F DWARF -Wall

SRC := hello_world.asm
OBJ := $(SRC:.asm=.o)
TARGET := helloWorld.out

all: $(TARGET)

%.o: %.asm
	$(NASM) $(NASMFLAGS) $< -o $@

$(TARGET): $(OBJ)
	ld -o $@ $^

clean:
	rm -f *.o
	rm -f $(TARGET)

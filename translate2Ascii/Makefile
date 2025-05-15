ASM     = nasm
ASMFLAGS= -f elf32
LD      = ld
LDFLAGS = -m elf_i386

SRC     = translate2Ascii.asm
OBJ     = translate2Ascii.o
BIN     = translate2Ascii

all: $(BIN)

$(BIN): $(OBJ)
	$(LD) $(LDFLAGS) -o $(BIN) $(OBJ)

$(OBJ): $(SRC)
	$(ASM) $(ASMFLAGS) $(SRC) -o $(OBJ)

run: $(BIN)
	./$(BIN)

clean:
	rm -f $(OBJ) $(BIN)

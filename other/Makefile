# We are all birds looking at god's computer monitor.

all: build

.PHONY: build run debug clean remove tar

# Directories
TARGET   = suijin
SRC_DIR  = src
LIB_DIR  = lib
BIN_DIR  = bin
OBJ_DIR  = .obj

# Options
CC       = gcc
CCFLAGS  = -ggdb3 -Og \
					 -Wall -march=native -mtune=native -fmodulo-sched \
					 -fstack-clash-protection -pthread \
					 -pipe -fkeep-inline-functions \
					 -D_FORTIFY_SOURCE=2

LINKER   = $(CC)

DEBUGGER = gdb -q
VALGRIND = valgrind --leak-check=summary --log-file=valgrind.log

DATE := $(shell date "+%Y-%m-%d")

LFLAGS = 

C_SRC = $(wildcard $(SRC_DIR)/*.c $(SRC_DIR)/*/*.c)
L_SRC = $(wildcard $(LIB_DIR)/*.c $(LIB_DIR)/*/*.c)
C_OBJ = $(C_SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
L_OBJ = $(L_SRC:$(LIB_DIR)/%.c=$(OBJ_DIR)/%.o)

build: $(BIN_DIR) $(BIN_DIR)/$(TARGET)

$(BIN_DIR):
	mkdir -p $@

$(C_OBJ): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) -c -fPIC $(CCFLAGS) $< -o $@

$(L_OBJ): $(OBJ_DIR)/%.o : $(LIB_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) -c -fPIC $(CCFLAGS) $< -o $@

$(BIN_DIR)/$(TARGET): $(C_OBJ) $(L_OBJ)
	$(CC) -o $(BIN_DIR)/$(TARGET) $(CCFLAGS) $(LFLAGS) $(L_OBJ) $(C_OBJ) $<

run: build
	./$(BIN_DIR)/$(TARGET)

valgrind: build
	$(VALGRIND) $(BIN_DIR)/$(TARGET)

debug: build
	$(DEBUGGER) $(BIN_DIR)/$(TARGET)

clean:
	rm -f $(C_OBJ)
	rm -f $(L_OBJ)
	rm -f $(BIN_DIR)/$(TARGET)

remove: clean
	rm -f $(BIN_DIR)/$(TARGET)

tar:
	tar -czvf $(TARGET)-$(DATE).tar.gz Makefile $(SRC_DIR)/* $(LIB_DIR)/* 

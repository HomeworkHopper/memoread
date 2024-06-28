INC = include
SRC = src
OUT = build
BIN = $(OUT)/main

CC = gcc
CPPFLAGS = -I$(INC) -I$(SRC)
CFLAGS = -Wall -Wextra -Werror -std=c99 -pedantic
LDLIBS =

MKDIR = mkdir -p
SRCs := $(shell find $(SRC) -name "*.c")
OBJs := $(subst $(SRC), $(OUT), $(SRCs:.c=.o))

all: $(BIN)

$(BIN): $(OBJs)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(OBJs) -o $@ $(LDLIBS)

$(OBJs): $(SRCs)
	$(MKDIR) $(dir $@)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $(subst $(OUT), $(SRC), $(@:.o=.c)) -o $@

clean:
	$(RM) -R $(OUT)

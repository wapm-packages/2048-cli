CC             ?= clang
CFLAGS         += -Wno-visibility -Wall -Wextra
CFLAGS         += -DINVERT_COLORS -DVT100
LFLAGS         +=
LDFLAGS         += -s WASM=1 -g2

PROGRAM := 2048.wasm
C_FILES := $(wildcard src/*.c)
MERGE_FILE := src/merge_std.c
FILTERED_C_FILES := $(filter-out src/gfx%.c src/merge%.c, $(C_FILES))

all: terminal

curses: $(FILTERED_C_FILES) src/gfx_curses.c
	$(CC) $(CFLAGS) $(FILTERED_C_FILES) $(MERGE_FILE) src/gfx_curses.c -o $(PROGRAM) $(LDFLAGS) -lcurses

terminal: $(FILTERED_C_FILES) src/gfx_terminal.c
	$(CC) $(CFLAGS) $(FILTERED_C_FILES) $(MERGE_FILE) src/gfx_terminal.c -o $(PROGRAM) $(LDFLAGS)

remake: clean all

clean:
	rm -f $(PROGRAM)

.PHONY: clean remake

# -------------------------------------------------------------
# Directories

BINDIR:= bin
SRCDIR:= src

BASEDIR:= ../../lib/sphinxbase
POCKETDIR:= ../../lib/pocketsphinx
MODELDIR:= $(POCKETDIR)/model

# -------------------------------------------------------------
# Compiler options

CC:= gcc
CFLAGS:= -Wall -Wextra -O3 -std=c11 -pedantic -Wno-unused-result

INC:= -I $(BASEDIR)/include -I $(POCKETDIR)/include

LIB:= -L $(BASEDIR)/src/libsphinxbase/.libs \
	  -L $(BASEDIR)/src/libsphinxad/.libs \
	  -L $(POCKETDIR)/src/libpocketsphinx/.libs \
	  -lpocketsphinx -lsphinxbase -lsphinxad

MACRO:= -D MODELDIR=\"$(MODELDIR)\"

# -------------------------------------------------------------
# Makefile variables

SRC:= $(wildcard $(SRCDIR)/*.c)
BIN:= $(patsubst $(SRCDIR)/%.c, $(BINDIR)/%, $(SRC))

# =============================================================

.PHONY: all clean sound_test help

# Compiles all source files
all: $(BIN)

$(BINDIR)/%: $(SRCDIR)/%.c | $(BINDIR)
	$(CC) $< -o $@ $(CFLAGS) $(INC) $(LIB) $(MACRO)
	@echo "\033[1m>> Generating C binary \033[32m"$@"\033[0m"

$(BINDIR):
	mkdir -p $@

# Cleans binaries
clean:
	rm -rf $(BINDIR)

# Tests a sound file
sound_test:
	aplay -f S16_LE -r 16000 sound/goforward.raw

help:
	@echo "[COMMANDS]"
	@echo "  - all:        Compile all source files, creating binaries in $(BINDIR)"
	@echo "  - clean:      Remove the created $(BINDIR) directory"
	@echo "  - help:       Show these instructions"
	@echo "  - sound_test: Example of how to listen to a raw audio file (16 bit, 16000Hz)"

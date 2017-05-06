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

.PHONY: all clean sound_test

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

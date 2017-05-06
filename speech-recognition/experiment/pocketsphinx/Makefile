# -------------------------------------------------------------
# Files

BIN:= hello_ps
SRC:= hello_ps.c

# -------------------------------------------------------------
# Directories

BINDIR:= bin
SRCDIR:= src

BASEDIR:= ../../lib/sphinxbase
POCKETDIR:= ../../lib/pocketsphinx
MODELDIR:= $(POCKETDIR)/model

# -------------------------------------------------------------
# Compiler Options

CC:= gcc
CFLAGS:= -Wall -Wextra -O3 -std=c99 -pedantic -Wno-unused-result

INC:= -I $(BASEDIR)/include -I $(POCKETDIR)/include

LIB:= -L $(BASEDIR)/src/libsphinxbase/.libs \
	  -L $(BASEDIR)/src/libsphinxad/.libs \
	  -L $(POCKETDIR)/src/libpocketsphinx/.libs \
	  -lpocketsphinx -lsphinxbase -lsphinxad

MACRO:= -D MODELDIR=\"$(MODELDIR)\"

# =============================================================

.PHONY: all clean sound_test

all: | $(BINDIR)
	$(CC) -o $(BINDIR)/$(BIN) $(SRCDIR)/$(SRC) $(CFLAGS) $(INC) $(LIB) $(MACRO)
	echo "\033[1m>> Generating C binary \033[32m"$(BIN)"\033[0m"

$(BINDIR):
	mkdir -p $@

clean:
	rm -rf $(BINDIR)

sound_test:
	aplay -f S16_LE -r 16000 sound/goforward.raw

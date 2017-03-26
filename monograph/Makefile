# ---------------------------------------------------------------------
# LaTeX-related files

TARGET  = main.pdf
TEMPTEX = *.aux *.fls *.log *.fdb_latexmk *.toc

# ---------------------------------------------------------------------
# Directories

AUXDIR = aux

# =====================================================================

.PHONY: all clean view

all:
	@[ -d aux/ ] || mkdir aux ||:
	@cd aux && mv * .. 2> /dev/null ||:
	latexmk -interaction=nonstopmode  -pdf $(TARGET:.pdf=)
	@mv *.aux *.fls *.log *.fdb_latexmk *.toc aux 2> /dev/null ||:

clean:
	latexmk -c

view:
	(evince $(TARGET) || atril $(TARGET)) &

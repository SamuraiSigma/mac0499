# ---------------------------------------------------------------------
# LaTeX-related files

MONO    = monograph
TARGET  = main.pdf
TEMPTEX = *.aux *.fdb_latexmk *.fls *.idx *.ilg *.ind *.lof *.log *.lot *.out *.toc

# ---------------------------------------------------------------------
# Directories

AUXDIR = aux

# =====================================================================

.PHONY: all clean view

all:
	@mkdir -p $(AUXDIR)
	@cd $(AUXDIR) && mv * .. 2> /dev/null ||:
	latexmk -interaction=nonstopmode -jobname=$(MONO) -pdf $(TARGET:.pdf=)
	@mv $(TEMPTEX) $(AUXDIR) 2> /dev/null ||:

clean:
	latexmk -c
	@rm -rf $(AUXDIR)

view:
	(evince $(TARGET) || atril $(TARGET)) &

# ---------------------------------------------------------------------
# LaTeX-related files

MONO    = monograph.pdf
TARGET  = main.tex
TEMPTEX = *.aux *.fdb_latexmk *.bbl *.blg *.brf *.fls *.idx *.ilg *.ind *.lof \
          *.log  *.lot *.out *.toc

# ---------------------------------------------------------------------
# Directories

AUXDIR = aux
TEXDIR = tex

# =====================================================================

.PHONY: all clean view

all:
	@mkdir -p $(AUXDIR)
	@cd $(AUXDIR) && mv * .. 2> /dev/null ||:
	latexmk -interaction=nonstopmode -jobname=$(MONO:.pdf=) -pdf $(TEXDIR)/$(TARGET)
	@mv $(TEMPTEX) $(AUXDIR) 2> /dev/null ||:

clean:
	rm -rf $(AUXDIR)

view: all
	@(evince $(MONO) || atril $(MONO)) &

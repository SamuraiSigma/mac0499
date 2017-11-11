# ---------------------------------------------------------------------
# LaTeX-related files

MONO    = Monografia.pdf
TARGET  = main.tex
TEMPTEX = *.aux *.fdb_latexmk *.bbl *.blg *.brf *.fls *.idx *.ilg *.ind *.lof \
          *.lol *.log  *.lot *.out *.toc

# ---------------------------------------------------------------------
# Directories

AUXDIR = aux
TEXDIR = tex

# =====================================================================

.PHONY: all spell-check clean view

all:
	@mkdir -p $(AUXDIR)
	@cd $(AUXDIR) && mv * .. 2> /dev/null ||:
	-latexmk -interaction=nonstopmode -jobname=$(MONO:.pdf=) -pdf $(TEXDIR)/$(TARGET)
	@mv $(TEMPTEX) $(AUXDIR) 2> /dev/null ||:

spell-check:
	@find $(TEXDIR) -type f | xargs cat | \
	aspell -l pt_BR -t list | aspell -l en_US list | sort | uniq -u

clean:
	rm -rf $(AUXDIR) $(TEMPTEX)

view:
	@[ -f $(MONO) ] || (echo "Must generate '$(MONO)' first!" && exit 1)
	(evince $(MONO) || atril $(MONO)) &

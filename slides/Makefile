# ---------------------------------------------------------------------
# LaTeX-related files

SLIDES  = Slides.pdf
TARGET  = main.tex
TEMPTEX = *.aux *.fdb_latexmk *.fls *.log *.nav *.out *.snm *.toc

# ---------------------------------------------------------------------
# Directories

AUXDIR = aux
TEXDIR = tex

# =====================================================================

.PHONY: all spell-check clean view

all:
	@mkdir -p $(AUXDIR)
	@cd $(AUXDIR) && mv * .. 2> /dev/null ||:
	-latexmk -interaction=nonstopmode -jobname=$(SLIDES:.pdf=) -pdf $(TEXDIR)/$(TARGET)
	@mv $(TEMPTEX) $(AUXDIR) 2> /dev/null ||:

spell-check:
	@find $(TEXDIR) -type f | xargs cat | \
	aspell -l pt_BR -t list | aspell -l en_US list | sort | uniq -u

clean:
	rm -rf $(AUXDIR) $(TEMPTEX)

view:
	@[ -f $(SLIDES) ] || (echo "Must generate '$(SLIDES)' first!" && exit 1)
	(evince $(SLIDES) || atril $(SLIDES)) &

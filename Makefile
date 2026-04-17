PAPER  = paper
LATEX  = pdflatex
BIBTEX = bibtex

.PHONY: all clean

all: $(PAPER).pdf

SECTIONS = $(wildcard sections/*.tex)

$(PAPER).pdf: $(PAPER).tex references.bib $(SECTIONS)
	$(LATEX)  $(PAPER)
	$(BIBTEX) $(PAPER)
	$(LATEX)  $(PAPER)
	$(LATEX)  $(PAPER)

clean:
	rm -f $(PAPER).{aux,bbl,blg,log,out,pdf,fls,fdb_latexmk,synctex.gz}

PAPER  = paper
LATEX  = pdflatex
BIBTEX = bibtex

.PHONY: all clean

all: $(PAPER).pdf

$(PAPER).pdf: $(PAPER).tex references.bib
	$(LATEX)  $(PAPER)
	$(BIBTEX) $(PAPER)
	$(LATEX)  $(PAPER)
	$(LATEX)  $(PAPER)

clean:
	rm -f $(PAPER).{aux,bbl,blg,log,out,pdf,fls,fdb_latexmk,synctex.gz}

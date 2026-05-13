PAPER  = paper
LATEX  = pdflatex
BIBTEX = bibtex

.PHONY: all clean

all: $(PAPER).pdf

SECTIONS = $(wildcard sections/*.tex)

# Seed a valid empty .bbl before the first LaTeX pass: natbib/acmart otherwise
# write a stub with doubled backslashes, which breaks \input{paper.bbl}.
$(PAPER).pdf: $(PAPER).tex references.bib $(SECTIONS) support/empty-bibliography.bbl
	cp support/empty-bibliography.bbl $(PAPER).bbl
	$(LATEX) $(PAPER)
	@if grep -q '^\\citation{' $(PAPER).aux 2>/dev/null; then $(BIBTEX) $(PAPER); fi
	$(LATEX) $(PAPER)
	$(LATEX) $(PAPER)

clean:
	rm -f $(PAPER).aux $(PAPER).bbl $(PAPER).blg $(PAPER).log \
		$(PAPER).out $(PAPER).pdf $(PAPER).fls $(PAPER).fdb_latexmk \
		$(PAPER).synctex.gz

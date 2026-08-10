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


###############################################################################
# Make Targets (Create Sources Tarball)
###############################################################################

BUILD_DIR=build

LATEXMK_OPTS=\
	-latexoption=-interaction=nonstopmode \
	-output-directory=$(BUILD_DIR)

LATEXMK=latexmk -pdf -logfilewarnings -f- $(LATEXMK_OPTS)

final: final.tar.gz

final.tar.gz : paper.tex $(DEPS)
	mkdir -p final
	latexpand --empty-comments --fatal $< | sed  '/^\s*%/d'  > final/main.tex
	rsync -avz *.bib final || true
	rsync -avz figures/*.pdf final/figures/ || true
	rsync -avz *.sty final/ || true
	rsync -avz *.cls final/ || true
	(cd final && $(LATEXMK) main.tex)
	cp final/build/main.pdf sources-main.pdf
	cp final/build/main.pdf final/$(PAPER).pdf
	cp final/build/main.bbl final/$(PAPER).bbl
	cp final/build/main.aux final/$(PAPER).aux
	rm -rf final/build
	(cd final && tar -czf ../sources.tar.gz *)


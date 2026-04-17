# Hardware Model Validation 

## Prerequisites

A TeX Live installation with the `acmart` class, or Docker.

## Building with Docker (recommended)

```bash
# Start the container (from the project root)
docker run --rm -it -v "$PWD:/workdir" -w /workdir ghcr.io/ayaka-notes/texlive-full:2025.1 bash

# Inside the container
make
```

The output is `paper.pdf`.

## Building natively

If you have TeX Live installed locally:

```bash
make
```

## Cleaning build artifacts

```bash
make clean
```


## Project structure

```
├── paper.tex              Main document (imports sections)
├── references.bib         Bibliography
├── Makefile               Build rules
├── .vscode/settings.json  Editor config (Docker-based LaTeX Workshop)
└── sections/
    ├── abstract.tex       Abstract
    ├── introduction.tex   Introduction (Context & Problem)
    ├── motivation.tex     Motivation
    ├── background.tex     Background (Formal Models, Observable Events, Synthesis)
    ├── model.tex          Proposed Model
    ├── reduction.tex      Reduction Argument (Cores, Paging Levels, PTE Addresses)
    ├── testgen.tex        Test-Case Generation
    ├── harness.tex        Testing Architecture
    ├── analysis.tex       Trace Analysis
    ├── evaluation.tex     Evaluation
    ├── related.tex        Related Work
    └── conclusion.tex     Conclusion
```


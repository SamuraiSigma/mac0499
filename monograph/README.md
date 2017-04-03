# Monograph

This directory contains all monograph-related files. The end document,
*Monografia.pdf*, is available only in *Portuguese*.

## Organization

This monograph consists in the following directories:

- **bib/**: Contains *BibTeX* files.

[//]: # (- **image/**: Contains images used throughout the document.)

- **tex/**: Contains the core *LaTeX* files.

## Generation

Assuming the user is using a Unix system and has `latexmk` installed, a PDF of the
monograph can be generated with:

    $ make

If all goes well, the *Monografia.pdf* file should be generated. Note that an
**aux/** directory will be created, containing temporary `latexmk` stuff used during
the document generation.

## View

The Makefile contains a shortcut for `evince` and/or `atril` users to view the PDF:

    $ make view

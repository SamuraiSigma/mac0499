# Slides

This directory contains all slides-related files. The end document, *Slides.pdf*, is
available only in *Portuguese*.

## Organization

This directory consists in the following subdirectories:

- [**image**](image/): Contains images used throughout the document.

- [**listing**](listing/): Contains listings (code, scripts, algorithms, etc.) used
  throughout the document.

- [**tex**](tex/): Contains the core *LaTeX* files.

## PDF creation

Assuming the user is on a Unix system and has `latexmk` installed, a PDF of the
slides can be generated with:

    $ make

If all goes well, the *Slides.pdf* file should be generated. Note that an **aux/**
directory will be created, containing temporary `latexmk` stuff used during the
document generation.

## View

The Makefile contains a shortcut for `evince` and/or `atril` users to view the PDF:

    $ make view

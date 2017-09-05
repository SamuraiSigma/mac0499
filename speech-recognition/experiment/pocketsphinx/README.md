# *Pocketsphinx* experiments

This directory contains code and test files to experiment with the *Pocketsphinx*
library (part of the [CMUSphinx][cmusphinx] project).

## Organization

This directory contains the following folders:

- [**bib**](kws/): Contains keyword files. These are used when searching for
specific words or sentences in an audio stream.

- [**sound**](sound/): Contains raw audio files that can be used for some tests.
Note that these files must be 16 bit, 16000Hz, or they won't work. To listen to
these files, follow the example showed when running:

      $ make sound_test

- [**src**](src/): Each source file inside this directory is a program on its own
that tests a *Pocketsphinx* feature. For more details on what command line arguments
a program may receive, check a header comment section on the respective source file.

The experiments consist in the following types:

- [audio_file_decoder](src/audio_file_decoder.c): Performs speech to text on a raw
  audio file.

- [keywords](src/keywords.c): Searches for keywords previously specified keywords
  on a raw audio file.

- [mic](src/mic.c): Continuously performs speech to text by receiving data from
  user's microphone.

- [mic_keywords](src/mic_keywords.c): Searches for previously specified words on
  the user's continuous microphone input.

## Build

First, make sure you have correctly built *Pocketsphinx* and *Sphinxbase* on the
[speech-recognition/lib](../../lib/) directory. After that, just type the following
to compile all source files:

    $ make

A **bin** directory will be created with all binary files.

## Run

Unless you have installed *Pocketsphinx* on your system, if you try running the
binaries directly, you will probably get something similar to the example below:

    $ ./bin/mic
    ./bin/mic: error while loading shared libraries: libpocketsphinx.so.3: cannot open shared object file: No such file or directory

This is because the environment variable `$LD_LIBRARY_PATH` was not set. To avoid the
problem of having to export this variable all the time, a script was provided to ease
the process.

In other words, to correctly run a program, use the [run.sh](run.sh) script with
the desired binary as the first argument. The second argument and beyond of the
script will be treated as the program's arguments. For example:

    $ ./run.sh bin/keywords sound/goforward.raw kws/goforward.kws

Is equivalent to running, with `$LD_LIBRARY_PATH` set:

    $ ./bin/keywords sound/goforward.raw kws/goforward.kws

[cmusphinx]: http://cmusphinx.sourceforge.net "CMUSphinx site"

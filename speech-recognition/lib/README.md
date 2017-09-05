# Speech recognition libraries

This directory contains submodules and scripts related to researched speech
recognition libraries for the new [Godot][godot] module.

## *Pocketsphinx*

A portable, fast speech recognition library written in C. Developed by
*Carnegie Mellon University* as part of their *CMUSphinx* project. For more
details, click [here][cmusphinx].

### Build

The *Pocketsphinx* submodule uses code from the *Sphinxbase* submodule. To build
both, run the [sphinx-compile.sh](sphinx-compile.sh) script located in this
directory:

    $ ./sphinx-compile.sh

Note that the following dependencies must already be installed:

`gcc, automake, autoconf, libtool, bison, swig (at least 2.0), python-dev,
pulseaudio`

### Test

To test if the library was correctly built, run the [sphinx-test.sh](sphinx-test.sh)
script located in this directory:

    $ ./sphinx-test.sh

The test involves continuous STT (Speech to Text) of the user's speech input through
their microphone. Use **Ctrl+C** to exit it anytime.

## *Kaldi*

*Kaldi* is a toolkit written in C. It is intended for use by speech recognition
researchers. Although considered more accurate and powerful than *Pocketsphinx*,
because of its complexity and larger size, not much research was done for it for the
sake of this project. For more details on *Kaldi*, click [here][kaldi].

[godot]: https://godotengine.org "Godot site"
[cmusphinx]: http://cmusphinx.sourceforge.net "CMUSphinx site"
[kaldi]: http://kaldi-asr.org/ "Kaldi site"

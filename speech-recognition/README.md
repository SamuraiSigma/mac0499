# Speech Recognition Libraries

This directory contains submodules and scripts related to researched speech
recognition libraries for the new [Godot][godot] module.

## Pocketsphinx

A portable, fast speech recognition library written in C. Developed by
*Carnegie Mellon University* as part of their *CMUSphinx* project. For more
details, click [here][cmusphinx].

The *Pocketsphinx* submodule uses code from the *Sphinxbase* submodule. To install
both, run the [sphinx-compile.sh](sphinx-compile.sh) script located in this
directory. Note that the following dependencies must already be installed:

`gcc, automake, autoconf, libtool, bison, swig (at least 2.0), python-dev,
pulseaudio`

[godot]: https://godotengine.org "Godot site"
[cmusphinx]: http://cmusphinx.sourceforge.net "CMUSphinx site"

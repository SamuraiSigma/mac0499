# *Godot*

This directory contains a fork of the [Godot][godot] game engine, as well as a fork
of the *Godot* documentation repository. Any work on the *Speech to Text* module is
done here.

## Building the engine with the module

The *Speech to Text* module was developed in the [speech-to-text][sttModule]
repository, available in this directory as a submodule.

To easily build executables related to the Godot engine, such as templates and the
editor, the [godot-builder.sh](godot-builder.sh) script is provided. For instructions
on how to use it, run in a terminal:

    $ ./godot-builder.sh -h

Many commands in this script to copy the *Speech to Text* module to the `engine/`
directory, which is a submodule for the Godot engine [repository][godotGitHub]. Of
course, to build for a determined platform, check if your system has the necessary
[requirements][compileReq]. This includes cross-compiling requirements, such as
building for Windows on a Unix platform.

## *Godot* docs

The [*docs/*](docs/) directory is a [fork][godotDocsGitHub] of the *Godot*
documentation repository. Updated with information on the *Speech to Text* module.

[godot]: https://godotengine.org "Godot site"
[sttModule]: https://github.com/SamuraiSigma/speech-to-text "Speech to text module on GitHub"
[godotGitHub]: https://github.com/godotengine/godot "Godot repository on GitHub"
[compileReq]: http://docs.godotengine.org/en/stable/development/compiling/index.html "Requirements for compiling"
[godotDocsGitHub]: https://github.com/godotengine/godot-docs "Godot docs on GitHub"

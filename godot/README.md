# *Godot*

This directory contains a fork of the [Godot][godot] game engine, as well as a fork
of the *Godot* documentation repository. Any work on the *Speech to Text* module is
done here.

## Building the engine with the module

The *Speech to Text* module was developed in the [speech-to-text][sttModule]
repository, available in this directory as a submodule.

To easily build and/or run the engine, use the [godot-builder.sh](godot-builder.sh)
script available in this directory:

    $ ./godot-builder.sh -h  # Displays usage of the script

This script can be used to copy the module to the `engine/` directory, which is a
submodule for the Godot engine [repository][godotGitHub], as well as easily build
the game engine and run it.

## *Godot* docs

The [*docs/*](docs/) directory is a [fork][godotDocsGitHub] of the *Godot*
documentation repository. Updated with information on the *Speech to Text* module.

[godot]: https://godotengine.org "Godot site"
[sttModule]: https://github.com/SamuraiSigma/speech-to-text "Speech to text module on GitHub"
[godotGitHub]: https://github.com/godotengine/godot "Godot repository on GitHub"
[godotDocsGitHub]: https://github.com/godotengine/godot-docs "Godot docs on GitHub"

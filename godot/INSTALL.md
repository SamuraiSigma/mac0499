# *Speech to Text* module for Godot

This is a Speech to Text (STT) module for [Godot][godot]. In other words, a module
that captures the user's microphone input and converts it to text.

If you are interested, check out the [Godot fork][godotFork] that contains
development on the module.

## Requirements

Aside from *Godot* building requirements (check the first subsection
[here][buildingGodot] for more information), *Speech to Text* has none. However, the
module only works on ***Unix*** systems that have ***Pulseaudio*** or ***Alsa***
support.

I've tested it successfully on *Godot* 2.1.3 and 2.1.4 [builds][godotGitHub].

## Building *Godot* with the module

The following steps assume that you are on a *Unix* system.

1. If you don't have the source code for *Godot*, clone its repository from
GitHub, and change to the latest stable build (when these instructions were made, it
was 2.1.4).

       $ git clone https://github.com/godotengine/godot
       $ git checkout 2.1.4-stable

2. Add the `modules/speech_to_text` folder to your *Godot* `modules/` directory.

3. Build *Godot*. Go to the root of your *Godot* source and type:

       $ scons platform=x11

4. Run *Godot*:

       $ ./bin/godot*tools*

5. Check if the ***STTRunner*** node was added to the existing nodes. This is a
good sign that the module was successfully added! To do this, follow these final
steps:

  5.1. After opening *Godot*, click the **New Project** button on the right side.
  Add a **Project Path** (I recommend an empty directory) and a **Project Name**
  (you are free to choose as you like).

  5.2. Click **Create** to open the *Godot* project editor window.

  5.3. On the right side, there should be the **Scene** tab with a window below it.
  Click the first icon below the **Scene** label, which has a plus symbol `+`, to
  create a new node.

  5.4. Check if the ***STTRunner*** appears in the list of nodes. It should probably
  be one of the last nodes in the list. There is also a search bar for convenience.

## Usage

Check the `docs/` folder for more information on how to use the module. The .html
files contained there are part of a [Godot Docs fork][godotDocsFork], in case the
full documentation is desired.

## Demo

[Here][colorClutter] is a repository containing a simple game, **Color Clutter**,
developed by me in *Godot* as a demo for the module.

If you wish to do a quick test, follow the instructions below to run the game:

1. Clone the game's repository.

       $ git clone https://github.com/SamuraiSigma/color-clutter

2. Run *Godot* with the directory created in the last step as the `-path` argument.

       $ ./bin/godot*tools* -path <color_clutter_directory>

Instructions on how to play are in the repository's `README.md` file.

## Contact

Found a bug, want to suggest something or simply chat? Feel free to send me an
email! :)

`samurai.sigma7@gmail.com`

[godot]: https://godotengine.org "Godot site"
[godotFork]: https://github.com/SamuraiSigma/godot "Godot fork with Speech to Text module"
[godotGitHub]: https://github.com/godotengine/godot "Godot repository on GitHub"
[buildingGodot]: http://docs.godotengine.org/en/stable/development/compiling/compiling_for_x11.html "Building Godot on Unix systems"
[godotDocsFork]: https://github.com/SamuraiSigma/godot-docs
[colorClutter]: https://github.com/SamuraiSigma/color-clutter

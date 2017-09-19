Speech to Text module for Godot
===============================

This is a Speech to Text (STT) module for Godot (https://godotengine.org). In other
words, a module that captures the user's microphone input and converts it to text.

If you are interested, check out the Godot fork that contains development on the
module: https://github.com/SamuraiSigma/godot.


Requirements
------------

The module only works on **Unix** systems that have **Pulseaudio** or **Alsa**
support.

First of all, check if your system fulfills Godot's building requirements, which can
be found on the link below:

http://docs.godotengine.org/en/stable/development/compiling/compiling_for_x11.html

Other than that, *Speech to Text* has no additional requirements. It is intended to
be used alongside a microphone connected to the system, which will capture voice
input.

I've tested it successfully on Godot 2.1.3 and 2.1.4 builds. Godot's repository can
be found on https://github.com/godotengine/godot.


Building *Godot* with the module
--------------------------------

The following steps assume that you are on a **Unix** system.

1. If you don't have the source code for Godot, clone its repository from GitHub.

       $ git clone https://github.com/godotengine/godot

2. Inside the cloned repository, change to the latest stable build that the module
   works on (when these instructions were made, it was 2.1.4).

       $ git checkout 2.1.4-stable

3. Add the `modules/speech_to_text` folder to your Godot `modules/` directory.

4. Build Godot. Go to the root of your Godot source and type:

       $ scons platform=x11

5. Run Godot:

       $ ./bin/godot*tools*

6. In order to check if the module was successfully added, follow these final steps:

  6.1. After opening Godot, click the **New Project** button on the right side to
       open the **Create New Project** window.

  6.2. On the new window, add a **Project Path** (I'd recommend an empty directory)
       and a **Project Name** (you are free to choose as you like).

  6.3. Click **Create** to open the Godot project editor window.

  6.4. On the right side, there should be a **Scene** tab with a window below it.
       Click the first icon below the **Scene** label, which has a plus symbol `+`,
       to create a new node.

  6.5. Check if the ***STTRunner*** appears in the list of nodes; it should probably
       be near the end of the list. There is also a search bar for convenience.


Usage
-----

Check the `docs/` folder for more information on how to use the module. The .html
files contained there are part of a Godot Docs fork located in the below link, in
case the full documentation is desired: https://github.com/SamuraiSigma/godot-docs.


Demo: Color Clutter
-------------------

**Color Clutter** is a simple game, developed by me in Godot as a demo for the
module.

If you wish to do a quick test, follow the instructions below to run the game:

1. Clone the game's repository.

       $ git clone https://github.com/SamuraiSigma/color-clutter

2. Run *Godot* with the directory created in the last step as the `-path` argument.

       $ ./bin/godot*tools* -path <color_clutter_directory>

Instructions on how to play are in the repository's `README.md` file.


Contact
-------

Found a bug, want to suggest something or simply chat? Feel free to send me an
email! :)

`samurai.sigma7@gmail.com`

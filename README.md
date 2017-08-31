# Development of a speech recognition module for the *Godot* game engine

This repository contains all data, code and texts for my **Supervised Gruaduate
Project (MAC0499)** at [IME-USP][ime-usp].

## Summary

[Godot][godot] is a open source 2D and 3D game engine, its code being available on
[GitHub][godotGitHub]. The software allows the creation of new modules to extend its
functionalities without modifying its essence.

This project's goal is to develop a *speech recognition* module for Godot and then
present the new functionality in a simple game.

## Schedule

|                     Activity                    | April | May | June  | July | August | September | October | November |
|:-----------------------------------------------:|:-----:|:---:|:-----:|:----:|:------:|:---------:|:-------:|:--------:|
| Search for speech recognition libraries to use  |   X   |     |       |      |        |           |         |          |
| Study the best speech recognition library found |       |  X  |       |      |        |           |         |          |
| Implement the new Godot module                  |       |     |   X   |   X  |    X   |           |         |          |
| Create a simple game with the new module        |       |     |       |      |    X   |     X     |         |          |
| Slides                                          |       |     |       |      |        |           |    X    |          |
| Poster                                          |       |     |       |      |        |           |    X    |          |
| Final touches                                   |       |     |       |      |        |           |         |     X    |

## Repository Organization

This project consists in the following directories:

- [**game**](game/): Contains a simple game, made in *Godot* to demonstrate the new
speech recognition module.

- [**godot**](godot/): *Godot* submodule, this is a fork of *Godot 2.1.3*. The new
module, *Speech Recognizer*, was developed here.

- [**monograph**](monograph/): A monograph registering steps done in the project (in
*Portuguese*).

- [**speech-recognition**](speech-recognition/): Contains submodules for speech
recognition libraries, as well as instructions and code on how to build them. Any
experiments done separately for each library are also located here.

[ime-usp]: https://www.ime.usp.br/en "IME-USP site"
[godot]: https://godotengine.org "Godot site"
[godotGitHub]:https://github.com/godotengine/godot "Godot repository on GitHub"

#!/bin/bash
# Runs a Godot game directory by using the custom Godot build that has the Speech
# Recognizer module.

set -e

GODOTDIR=../godot
GODOTBIN=godot*

#----------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` <game_directory>\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tRuns the specified game with a custom Godot version that has the Speech Recognizer module.\n"

    echo -e "\e[1mCOMMAND LINE ARGUMENTS\e[0m"
    echo -e "\t\e[1m<game_directory>\e[0m\tGame directory containing an engine.cfg file."
}

# ---------------------------------------------------------------------

if (($# < 1)); then
    usage
    exit 1
fi

gamedir=$1
export LD_LIBRARY_PATH=`pwd`/$GODOTDIR/bin
./$GODOTDIR/bin/$GODOTBIN -path $gamedir

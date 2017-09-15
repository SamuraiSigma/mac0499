#!/bin/bash
# Runs a Godot game directory by using the custom Godot build that has the Speech
# Recognizer module.

set -e

GODOTDIR=../godot/engine  # Godot engine directory
BINDIR=bin                # Binary directory
BIN=godot*tools*          # Binary name

#----------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` <\e[4mGAME_DIR\e[0m> [\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tRuns the specified game in GAME_DIR with a custom Godot version" \
            "has the Speech Recognizer module.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\t\e[1m-h, --help\e[0m\n\t\tShows how to use the script, leaving it" \
            "afterwards."
}

# ---------------------------------------------------------------------

if (($# < 1)); then
    usage
    exit 1
fi

for arg in "$@"; do
    case $arg in
    -h|--help)
        usage
        exit 0;;
    esac
done

gamedir=$1
export LD_LIBRARY_PATH=`pwd`/$GODOTDIR/$BINDIR
./$GODOTDIR/$BINDIR/$BIN -path $gamedir

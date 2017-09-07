#!/bin/bash
# Script for building/running Godot with the Speech to Text module.

set -e

GODOTDIR=engine  # Godot engine directory

#----------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` [\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tBuilds Godot in development mode with the Speech to Text module as" \
            "a shared library.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\tSeparate each option with a space.\n"

    echo -e "\t\e[1m-r\e[0m\tRuns Godot after building it.\n"
    echo -e "\t\e[1m-R\e[0m\tOnly runs the previously created Godot binary" \
            "(nothing new is built).\n"
    echo -e "\t\e[1m-h, --help\e[0m\n\t\tShows how to use the script, leaving it" \
            "afterwards."
}

# ---------------------------------------------------------------------

compile=1  # If true (1), Godot engine will be compiled
run=0      # If true (1), Godot engine will be executed

for arg in "$@"; do
    case $arg in
    -r)
        compile=1
        run=1;;
    -R)
        compile=0
        run=1;;
    -h|--help)
        usage
        exit 0;;
    *)
        echo "Unknown argument '$arg'"
        usage
        exit 1;;
    esac
done

if (($compile)); then
    echo -e "\033[1;36m>> Cloning Godot engine submodule\033[0m"
    git submodule init $GODOTDIR && git submodule update $GODOTDIR
fi

cd $GODOTDIR

if (($compile)); then
    echo -e "\033[1;36m>> Building Godot engine\033[0m"
    scons p=x11 speech_to_text_shared=yes bin/libspeech_to_text.x11.tools.64.so
    scons p=x11 speech_to_text_shared=yes
fi

if (($run)); then
    echo -e "\033[1;36m>> Running Godot engine\033[0m"
    LD_LIBRARY_PATH=`pwd`/bin/ bin/godot.x11.tools.64
fi

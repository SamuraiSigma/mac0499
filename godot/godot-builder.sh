#!/bin/bash
# Script for building/running Godot with the Speech to Text module.

set -e

GODOTDIR=engine        # Godot engine directory
MODDIR=speech-to-text  # Speech to text directory

#----------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` [\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tBuilds the Godot engine editor with the Speech to Text module as" \
            "a shared library.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\tSeparate each option with a space.\n"

    echo -e "\t\e[1m-r\e[0m\tRuns Godot after building it.\n"
    echo -e "\t\e[1m-R\e[0m\tOnly runs the previously created Godot binary" \
            "(nothing new is built).\n"
    echo -e "\t\e[1m-u\e[0m\tBuilds export templates for Unix (64 bits).\n"
    echo -e "\t\e[1m-h, --help\e[0m\n\t\tShows how to use the script, leaving it" \
            "afterwards."
}

# ---------------------------------------------------------------------

compile=0  # If true (1), Godot engine will be compiled
run=0      # If true (1), Godot engine will be executed
unix=0     # If true (1), Unix export templates will be built

for arg in "$@"; do
    case $arg in
    -r)
        compile=1
        run=1;;
    -R)
        compile=0
        linux=0
        run=1;;
    -u)
        unix=1;;
    -h|--help)
        usage
        exit 0;;
    *)
        echo "Unknown argument '$arg'"
        usage
        exit 1;;
    esac
done

if (($compile || $unix)); then
    echo -e "\033[1;36m>> Cloning submodules\033[0m"
    git submodule update --init $GODOTDIR $MODDIR
    cp -rf $MODDIR/speech_to_text $GODOTDIR/modules
fi

cd $GODOTDIR

if (($compile)); then
    echo -e "\033[1;36m>> Building Godot engine\033[0m"
    scons p=x11 speech_to_text_shared=yes bin/libspeech_to_text.x11.tools.64.so
    scons p=x11 speech_to_text_shared=yes
fi

if (($unix)); then
    echo -e "\033[1;36m>> Building export templates for Unix\033[0m"
    scons tools=no p=x11 target=release bits=64
    scons tools=no p=x11 target=release_debug bits=64
fi

if (($run)); then
    echo -e "\033[1;36m>> Running Godot engine\033[0m"
    LD_LIBRARY_PATH=`pwd`/bin/ bin/godot.x11.tools.64
fi

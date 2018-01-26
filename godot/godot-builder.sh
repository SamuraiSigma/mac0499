#!/bin/bash
# Script for building/running Godot with the Speech to Text module.

set -e

GODOTDIR=engine        # Godot engine directory
MODDIR=speech-to-text  # Speech to text directory

#----------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` <\e[4mOPTIONS\e[0m>\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tAuxiliary script for building Godot engine executables with" \
            "Speech to Text module integration.\n" \
            "\tActions taken depend on the options used.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\tSeparate each option with a space.\n"

    echo -e "\t\e[1m-B\e[0m\tBuilds the Godot editor.\n"
    echo -e "\t\e[1m-R\e[0m\tRuns the previously created Godot editor binary.\n"
    echo -e "\t\e[1m-j <NUM_CORES>\e[0m\n\t\tSpecifies number of cores to use for" \
            "any kind of build (default: 1).\n"
    echo -e "\t\e[1m-u\e[0m\tBuilds export templates for Unix (32 bits).\n"
    echo -e "\t\e[1m-U\e[0m\tBuilds export templates for Unix (64 bits).\n"
    echo -e "\t\e[1m-w\e[0m\tBuilds export templates for Windows (32 bits).\n"
    echo -e "\t\e[1m-W\e[0m\tBuilds export templates for Windows (64 bits).\n"
    echo -e "\t\e[1m-x\e[0m\tBuilds export templates for OS X (32 bits).\n"
    echo -e "\t\e[1m-X\e[0m\tBuilds export templates for OS X (64 bits).\n"
    echo -e "\t\e[1m-h, --help\e[0m\n\t\tShows how to use the script, leaving it" \
            "afterwards."
}

# ---------------------------------------------------------------------

cores=1      # Number of cores to use for building
compile=0    # Compile Godot editor
run=0        # Run Godot editor

# Build template flags
unix32=0
unix64=0
windows32=0
windows64=0
osx32=0
osx64=0

if (($# < 1)); then
    usage
    exit 1
fi

# Check command line arguments
while (($#)); do
    case $1 in
    -B)
        compile=1;;
    -R)
        run=1;;
    -j)
        shift
        cores=$1
        max_cores=$(nproc --all)
        if (($cores < 1 || $cores > $max_cores)); then
            echo "Error: Invalid number of cores $cores"
            exit 2
        fi
        echo "Using $cores cores for builds";;
    -u)
        unix32=1;;
    -U)
        unix64=1;;
    -w)
        windows32=1;;
    -W)
        windows64=1;;
    -x)
        osx32=1;;
    -X)
        osx64=1;;
    -h|--help)
        usage
        exit 0;;
    *)
        echo "Unknown argument '$1'"
        usage
        exit 3;;
    esac
    shift
done

if (($compile || $unix32 || $unix64 || $windows32 || $windows64 ||
     $osx32 || $osx64)); then
    echo -e "\033[1;36m>> Cloning submodules\033[0m"
    git submodule update --init $GODOTDIR $MODDIR
    cp -rf $MODDIR/speech_to_text $GODOTDIR/modules
fi

cd $GODOTDIR

if (($compile)); then
    echo -e "\033[1;36m>> Building Godot engine\033[0m"
    scons -j$cores p=x11 speech_to_text_shared=yes bin/libspeech_to_text.x11.tools.64.so
    scons -j$cores p=x11 speech_to_text_shared=yes
fi

if (($unix32)); then
    echo -e "\033[1;36m>> Building export templates for Unix (32 bits)\033[0m"
    scons -j$cores tools=no p=x11 target=release bits=32
    scons -j$cores tools=no p=x11 target=release_debug bits=32
fi

if (($unix64)); then
    echo -e "\033[1;36m>> Building export templates for Unix (64 bits)\033[0m"
    scons -j$cores tools=no p=x11 target=release bits=64
    scons -j$cores tools=no p=x11 target=release_debug bits=64
fi

if (($windows32)); then
    echo -e "\033[1;36m>> Building export templates for Windows (32 bits)\033[0m"
    scons -j$cores tools=no p=windows target=release bits=32
    scons -j$cores tools=no p=windows target=release_debug bits=32
fi

if (($windows64)); then
    echo -e "\033[1;36m>> Building export templates for Windows (64 bits)\033[0m"
    scons -j$cores tools=no p=windows target=release bits=64
    scons -j$cores tools=no p=windows target=release_debug bits=64
fi

if (($osx32)); then
    echo -e "\033[1;36m>> Building export templates for OS X (32 bits)\033[0m"
    scons -j$cores tools=no p=osx osxcross_sdk=darwin15 target=release bits=32
    scons -j$cores tools=no p=osx osxcross_sdk=darwin15 target=release_debug bits=32
fi

if (($osx64)); then
    echo -e "\033[1;36m>> Building export templates for OS X (64 bits)\033[0m"
    scons -j$cores tools=no p=osx osxcross_sdk=darwin15 target=release bits=64
    scons -j$cores tools=no p=osx osxcross_sdk=darwin15 target=release_debug bits=64
fi

if (($run)); then
    echo -e "\033[1;36m>> Running Godot engine\033[0m"
    LD_LIBRARY_PATH=`pwd`/bin/ bin/godot.x11.tools.64
fi

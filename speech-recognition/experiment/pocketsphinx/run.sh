#!/bin/bash
# Wrapper script that runs programs by first exporting the LD_LIBRARY_PATH
# variable. Used for easily running Pocketsphinx applications.

set -e

BASEDIR=../../lib/sphinxbase      # Sphinxbase directory
POCKETDIR=../../lib/pocketsphinx  # Pocketsphinx

# Library paths used on LD_LIBRARY_PATH
LIBPATH=$BASEDIR/src/libsphinxbase/.libs
LIBPATH+=:$BASEDIR/src/libsphinxad/.libs
LIBPATH+=:$POCKETDIR/src/libpocketsphinx/.libs

# ---------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` <\e[4mBINARY\e[0m [\e[4mBINARY_ARGS\e[0m]\e[0m>" \
            "[\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tRuns the specified BINARY, with its arguments BINARY_ARGS, by" \
            "using the local Pocketsphinx library path.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\tSeparate each option with a blank space.\n"

    echo -e "\t\e[1m-h, --help\e[0m\n\t\tShows how to use the script, leaving it" \
            "afterwards."
}

# ---------------------------------------------------------------------

if (($# < 1)); then
    echo "Must specify program name as first argument!"
    exit 1
fi

for arg in $@; do
    case $arg in
        -h|--help)
            usage $0
            exit 0;;
    esac
done

LD_LIBRARY_PATH=$LIBPATH ./$1 ${@:2}

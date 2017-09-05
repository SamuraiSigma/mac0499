#!/bin/bash
# Clones and builds sphinxbase and pocketsphinx from source.

set -e

# Sphinx directories
BASEDIR=sphinxbase
POCKETDIR=pocketsphinx

# ---------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` [\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tClones and builds sphinxbase and pocketsphinx from source.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\tSeparate each option with a blank space.\n"

    echo -e "\t\e[1m-b\e[0m\tBuild sphinxbase only; overwritten by \e[1m-p\e[0m.\n"
    echo -e "\t\e[1m-p\e[0m\tBuild pocketsphinx only; overwritten by \e[1m-b\e[0m.\n"
    echo -e "\t\e[1m-h, --help\e[0m\n\t\tShows how to use the script, leaving it" \
            "afterwards."
}

# ---------------------------------------------------------------------

base=true
pocket=true

for arg in $@; do
    case $arg in
        -b)
            base=true
            pocket=false;;
        -p)
            pocket=true
            base=false;;
        -h|--help)
            usage $0
            exit 0;;
        *)
            echo -e "$0: Unknown argument '$arg'\n"
            usage $0
            exit 1;;
    esac
done

if $base; then
    echo -e "\033[1;36m>> Cloning sphinxbase repository\033[0m"
    git submodule init $BASEDIR && git submodule update $BASEDIR

    echo -e "\033[1;36m>> Building sphinxbase\033[0m"
    cd $BASEDIR
    ./autogen.sh && ./configure && make && make check
    cd ..
fi

if $pocket; then
    echo -e "\033[1;36m>> Cloning pocketsphinx repository\033[0m"
    git submodule init $POCKETDIR && git submodule update $POCKETDIR

    echo -e "\033[1;36m>> Building pocketsphinx\033[0m"
    cd $POCKETDIR
    ./autogen.sh && ./configure && make clean all && make check
    cd ..
fi

echo -e "\033[1;36m>> Done!\033[0m"

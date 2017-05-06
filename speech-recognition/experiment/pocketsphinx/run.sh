#!/bin/bash
# Wrapper script that runs programs by first exporting the LD_LIBRARY_PATH variable
# for Pocketsphinx applications.

set -e

BASEDIR=../../lib/sphinxbase      # Sphinxbase directory
POCKETDIR=../../lib/pocketsphinx  # Pocketsphinx

# Library paths used on LD_LIBRARY_PATH
LIBPATH=$BASEDIR/src/libsphinxbase/.libs:
LIBPATH+=$BASEDIR/src/libsphinxad/.libs:
LIBPATH+=$POCKETDIR/src/libpocketsphinx/.libs

# ---------------------------------------------------------------------

if (($# < 1)); then
    echo "Must specify program name as first argument!"
    exit 1
fi

LD_LIBRARY_PATH=$LIBPATH ./$1 ${@:2}

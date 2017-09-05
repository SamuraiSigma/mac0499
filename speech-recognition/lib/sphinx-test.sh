#!/bin/bash
# Runs a continuous microphone STT test using Pocketsphinx.

set -e

# Pocketsphinx directories
POCKETDIR="pocketsphinx"
MODELDIR="$POCKETDIR/model"  # Directory with dictionaries, models, etc.

# Binary used to test speech recognition
BIN="$POCKETDIR/src/programs/pocketsphinx_continuous"

# ---------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` [\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tRuns a continuous microphone STT test using Pocketsphinx.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\tSeparate each option with a blank space.\n"

    echo -e "\t\e[1m-h, --help\e[0m\n\t\tShows how to use the script, leaving it" \
            "afterwards."
}

# ---------------------------------------------------------------------

for arg in $@; do
    case $arg in
        -h|--help)
            usage $0
            exit 0;;
    esac
done

./$BIN \
-mdef $MODELDIR/en-us/en-us/mdef \
-tmat $MODELDIR/en-us/en-us/transition_matrices \
-mean $MODELDIR/en-us/en-us/means \
-var $MODELDIR/en-us/en-us/variances \
-sendump $MODELDIR/en-us/en-us/sendump \
-featparams $MODELDIR/en-us/en-us/feat.params \
-dict $MODELDIR/en-us/cmudict-en-us.dict \
-lm $MODELDIR/en-us/en-us.lm.bin \
-inmic yes

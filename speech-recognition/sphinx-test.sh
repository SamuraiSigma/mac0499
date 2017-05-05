#!/bin/bash

POCKETDIR="pocketsphinx"
MODELDIR="$POCKETDIR/model"  # Directory with dictionaries, models, etc.

# Binary used to test speech recognition
BIN="$POCKETDIR/src/programs/pocketsphinx_continuous"

# ---------------------------------------------------------------------

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

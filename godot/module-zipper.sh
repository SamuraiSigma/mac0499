#!/bin/bash
# Creates a zip with the Speech to Text module and its documentation.

set -e

# Module name
STTNAME=speech_to_text

# Directory with the Speech to Text module
STTDIR=engine/modules/$STTNAME

# Godot docs directory
DOCDIR=docs

# Created zip directory and filename
ZIPDIR="godot-stt"

#----------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` [\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tCreates a zip with the Speech to Text module and its documentation.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\tSeparate each option with a space.\n"

    echo -e "\t\e[1m-h, --help\e[0m\n\t\tShows how to use the script, leaving it" \
            "afterwards."
}

# ---------------------------------------------------------------------

for arg in "$@"; do
    case $arg in
        -h|--help)
            usage
            exit 0;;
    esac
done

rm -rf $ZIPDIR $ZIPDIR.zip
mkdir -p $ZIPDIR $ZIPDIR/modules

# Copy module and remove unnecessary files
echo -e "\033[1;36m>> Copying module files\033[0m"
cp -rf $STTDIR $ZIPDIR/modules
find $ZIPDIR/modules/$STTNAME -name "*.os" | xargs rm -f
find $ZIPDIR/modules/$STTNAME -name "*.pyc" | xargs rm -f
rm -rf $ZIPDIR/modules/$STTNAME/doc

# Create HTML docs
echo -e "\033[1;36m>> Getting HTML docs\033[0m"
pushd $DOCDIR > /dev/null
make html
popd > /dev/null

# Copy HTML docs
mkdir -p $ZIPDIR/doc $ZIPDIR/doc/classes $ZIPDIR/doc/_images \
         $ZIPDIR/doc/community $ZIPDIR/doc/community/tutorials \
         $ZIPDIR/doc/community/tutorials/misc \
         $ZIPDIR/doc/_sources $ZIPDIR/doc/_sources/classes
cp -rf $ZIPDIR/doc/community $ZIPDIR/doc/_sources

cp -rf $DOCDIR/_build/html/_static $ZIPDIR/doc
cp -f $DOCDIR/_build/html/_images/stt_diagram.png $ZIPDIR/doc/_images
cp -f $DOCDIR/_build/html/classes/class_stt*.html $ZIPDIR/doc/classes
cp -f $DOCDIR/_build/html/community/tutorials/misc/speech_to_text.html \
      $ZIPDIR/doc/community/tutorials/misc
cp -f $DOCDIR/_build/html/_sources/classes/class_stt*.rst.txt \
      $ZIPDIR/doc/_sources/classes
cp -f $DOCDIR/_build/html/_sources/community/tutorials/misc/speech_to_text.rst.txt \
      $ZIPDIR/doc/_sources/community/tutorials/misc

# Create zip
zip -r $ZIPDIR $ZIPDIR
rm -rf $ZIPDIR
echo -e "\033[1;36m>> Successfully created zip file '$ZIPDIR'\033[0m"

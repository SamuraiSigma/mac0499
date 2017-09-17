#!/bin/bash
# Creates a tar.gz with the Speech to Text module and its documentation.

set -e

TARDIR="godot-stt"              # Created tar.gz directory
TARNAME=$TARDIR.tar.gz          # Compressed filename

STTNAME=speech_to_text          # Module name
STTDIR=engine/modules/$STTNAME  # Directory with the Speech to Text module

DOCDIR=docs                     # Godot docs directory
HTMLDIR=$DOCDIR/_build/html     # Godot docs html directory

INSTALL=INSTALL.md              # Install instructions

#----------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t./`basename $0` [\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tCreates a tar.gz with the Speech to Text module and its" \
            "documentation.\n"

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

rm -rf $TARDIR $TARDIR.zip
mkdir -p $TARDIR $TARDIR/modules

# Copy module and remove unnecessary files
echo -e "\033[1;36m>> Copying module files\033[0m"
cp -rf $STTDIR $TARDIR/modules
find $TARDIR/modules/$STTNAME -name "*.o" | xargs rm -f
find $TARDIR/modules/$STTNAME -name "*.os" | xargs rm -f
find $TARDIR/modules/$STTNAME -name "*.pyc" | xargs rm -f
rm -rf $TARDIR/modules/$STTNAME/doc $TARDIR/modules/$STTNAME/.gitignore

# Create HTML docs
echo -e "\033[1;36m>> Getting HTML docs\033[0m"
pushd $DOCDIR > /dev/null
make html
popd > /dev/null

# Copy HTML docs
mkdir -p $TARDIR/docs $TARDIR/docs/classes $TARDIR/docs/_images \
         $TARDIR/docs/community $TARDIR/docs/community/tutorials \
         $TARDIR/docs/community/tutorials/misc \
         $TARDIR/docs/_sources $TARDIR/docs/_sources/classes
cp -rf $TARDIR/docs/community $TARDIR/docs/_sources

cp -rf $HTMLDIR/_static $TARDIR/docs
cp -f $HTMLDIR/_images/stt_diagram.png $TARDIR/docs/_images
cp -f $HTMLDIR/classes/class_stt*.html $TARDIR/docs/classes
cp -f $HTMLDIR/community/tutorials/misc/speech_to_text.html \
      $TARDIR/docs/community/tutorials/misc
cp -f $HTMLDIR/_sources/classes/class_stt*.rst.txt \
      $TARDIR/docs/_sources/classes
cp -f $HTMLDIR/_sources/community/tutorials/misc/speech_to_text.rst.txt \
      $TARDIR/docs/_sources/community/tutorials/misc

# Copy install instructions and license
cp -f INSTALL.md $TARDIR/README.md
cp -f $TARDIR/modules/$STTNAME/LICENSE.md $TARDIR

# Create tar.gz
echo -e "\033[1;36m>> Compressing files\033[0m"
tar -czvf $TARNAME $TARDIR
rm -rf $TARDIR

echo -e "\033[1;36m>> Successfully created compressed file '$TARNAME'\033[0m"

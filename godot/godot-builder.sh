#!/bin/bash
# Script for building/running Godot with the Speech to Text module.

set -e

# Enables iPhone platform to be detected
export OSXCROSS_IOS=anything

# ---------------------------------------------------------------------
# Files and directories

GODOTDIR=engine        # Godot engine directory
BINDIR=bin             # Godot engine binaries directory
MODDIR=speech-to-text  # Speech to text directory

OSXCROSS_SDK="darwin15"           # Version of OSXCross SDK to use
IOS_TRIPLE="arm-apple-darwin11-"  # Toolchain to use on iOS

#----------------------------------------------------------------------
# Shows how to use the script

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
    echo -e "\t\e[1m-x, -X\e[0m\n" \
            "\t\tBuilds fat export template (app) for OS X (32 and 64 bits).\n" \
            "\t\tNote: You must define the OSXCross path with \$OSXCROSS_ROOT.\n"
    echo -e "\t\e[1m-i, -I\e[0m\n" \
            "\t\tBuilds fat export templates for iOS (arm and arm64).\n" \
            "\t\tNote: You must define the iOS SDK and toolchain paths with" \
            "\$IOS_SDK and \$IOS_TOOLCHAIN, respectively.\n"
    echo -e "\t\e[1m-a, -A\e[0m\n" \
            "\t\tBuilds fat export templates (apks) for Android (x86 and armv7).\n" \
            "\t\tNote: You must define the Android SDK and NDK paths with" \
            "\$ANDROID_HOME and \$ANDROID_NDK_ROOT, respectively.\n"
    echo -e "\t\e[1m-h, --help\e[0m\n" \
            "\t\tShows how to use the script, leaving it afterwards."
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
osx=0
ios=0
android=0

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
    -x|-X)
        osx=1;;
    -i|-I)
        ios=1;;
    -a|-A)
        android=1;;
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

if (($compile || $unix32 || $unix64 || $windows32 || $windows64 || $osx || $ios || $android)); then
    echo -e "\033[1;36m>> Cloning submodules\033[0m"
    git submodule update --init $GODOTDIR $MODDIR
    cp -rf $MODDIR/speech_to_text $GODOTDIR/modules
fi

cd $GODOTDIR

if (($compile)); then
    echo -e "\033[1;36m>> Building Godot engine editor\033[0m"
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

if (($osx)); then
    if ! [[ -n $OSXCROSS_ROOT ]]; then
        echo -e "\033[1;31m>> Cannot build export templates for OS X;" \
                "\$OSXCROSS_ROOT not defined!\033[0m"
        exit 4
    fi

    echo -e "\033[1;36m>> Building export templates for OS X (32 bits)\033[0m"
    scons -j$cores tools=no p=osx osxcross_sdk=$OSXCROSS_SDK target=release bits=32
    scons -j$cores tools=no p=osx osxcross_sdk=$OSXCROSS_SDK target=release_debug bits=32
    echo -e "\033[1;36m>> Building export templates for OS X (64 bits)\033[0m"
    scons -j$cores tools=no p=osx osxcross_sdk=$OSXCROSS_SDK target=release bits=64
    scons -j$cores tools=no p=osx osxcross_sdk=$OSXCROSS_SDK target=release_debug bits=64

    echo -e "\033[1;36m>> Creating OS X app with fat binaries\033[0m"
    cp -rf misc/dist/osx_template.app $BINDIR
    cd $BINDIR
    mkdir -p osx_template.app/Contents/MacOS

    $OSXCROSS_ROOT/target/bin/x86_64-apple-${OSXCROSS_SDK}-lipo \
    -create godot.osx.opt.32 godot.osx.opt.64 \
    -output osx_template.app/Contents/MacOS/godot_osx_release.fat
    $OSXCROSS_ROOT/target/bin/x86_64-apple-${OSXCROSS_SDK}-lipo \
    -create godot.osx.opt.debug.32 godot.osx.opt.debug.64 \
    -output osx_template.app/Contents/MacOS/godot_osx_debug.fat

    zip -r osx.zip osx_template.app
    rm -rf osx_template.app
    cd ..
    echo "Done!"
fi

if (($ios)); then
    if ! [[ -n $IOS_SDK ]]; then
        echo -e "\033[1;31m>> Cannot build export templates for iOS;" \
                "\$IOS_SDK not defined!\033[0m"
        exit 5
    fi
    if ! [[ -n $IOS_TOOLCHAIN ]]; then
        echo -e "\033[1;31m>> Cannot build export templates for iOS;" \
                "\$IOS_TOOLCHAIN not defined!\033[0m"
        exit 6
    fi

    echo -e "\033[1;36m>> Building export templates for iOS (arm)\033[0m"
    scons -j$cores p=iphone arch=arm target=release \
          IPHONESDK=$IOS_SDK IPHONEPATH=$IOS_TOOLCHAIN ios_triple=$IOS_TRIPLE
    scons -j$cores p=iphone arch=arm target=release_debug \
          IPHONESDK=$IOS_SDK IPHONEPATH=$IOS_TOOLCHAIN ios_triple=$IOS_TRIPLE
    echo -e "\033[1;36m>> Building export templates for iOS (arm64)\033[0m"
    scons -j$cores p=iphone arch=arm64 target=release \
          IPHONESDK=$IOS_SDK IPHONEPATH=$IOS_TOOLCHAIN ios_triple=$IOS_TRIPLE
    scons -j$cores p=iphone arch=arm64 target=release_debug \
          IPHONESDK=$IOS_SDK IPHONEPATH=$IOS_TOOLCHAIN ios_triple=$IOS_TRIPLE

    echo -e "\033[1;36m>> Creating fat iOS binaries\033[0m"
    $IOS_TOOLCHAIN/usr/bin/${IOS_TRIPLE}lipo \
    -create bin/godot.iphone.opt.arm bin/godot.iphone.opt.arm64 \
    -output bin/godot.iphone.opt.fat
    $IOS_TOOLCHAIN/usr/bin/${IOS_TRIPLE}lipo \
    -create bin/godot.iphone.opt.debug.arm bin/godot.iphone.opt.debug.arm64 \
    -output bin/godot.iphone.opt.debug.fat

    echo "Done!"
fi

if (($android)); then
    if ! [[ -n $ANDROID_HOME ]]; then
        echo -e "\033[1;31m>> Cannot build export templates for Android;" \
                "\$ANDROID_HOME not defined!\033[0m"
        exit 7
    fi
    if ! [[ -n $ANDROID_NDK_ROOT ]]; then
        echo -e "\033[1;31m>> Cannot build export templates for Android;" \
                "\$ANDROID_NDK_ROOT not defined!\033[0m"
        exit 8
    fi

    echo -e "\033[1;36m>> Building export templates for Android (x86)\033[0m"
    scons -j$cores p=android target=release android_arch=x86
    scons -j$cores p=android target=release_debug android_arch=x86
    echo -e "\033[1;36m>> Building export templates for Android (armv7)\033[0m"
    scons -j$cores p=android target=release
    scons -j$cores p=android target=release_debug

    echo -e "\033[1;36m>> Creating fat Android apks with Gradle\033[0m"
    pushd platform/android/java > /dev/null
    ./gradlew build
    popd > /dev/null
fi

if (($run)); then
    echo -e "\033[1;36m>> Running Godot engine\033[0m"
    LD_LIBRARY_PATH=`pwd`/bin/ bin/godot.x11.tools.64
fi

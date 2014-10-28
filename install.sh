#!/bin/bash

function splash {
    echo ""
    echo -e "\e[0;32m\e[40m                                                     \e[0m"
    echo -e "\e[0;32m\e[40m      GAPI - Graph Application Programming Interface \e[0m"
    echo -e "\e[0;32m\e[40m      version: 1.0a                                  \e[0m"
    echo -e "\e[0;32m\e[40m                                                     \e[0m"
}
function msg {
    echo -ne "\e[0;37m\e[40m >>> \e[m "
    if [[ $1 == "n" ]] ; then
        echo -ne "$2"
    else
        echo -e "$1"
    fi
}
function err {
    echo -ne "\e[0;91m\e[40m >>> \e[m "
    echo $1   
}
function ask {
    while true; do
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question
        msg n "$1 [$prompt] "
        read REPLY

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}

splash

IPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #"
IDIR="$IPATH/core"

# check arguments
if [ ! -z "$1" ]; then
    IDIR="$1"
fi
# absolute path test
if [[ $IDIR != /* ]] ; then
    IDIR="$IPATH/$IDIR"
fi

# create target directory and cd there
msg "Create install directory... $IDIR"
if mkdir -p "$IDIR" ; then
    cd $IDIR
else
    err "Creating directory failed."
    exit 1
fi

# clone base
msg "Cloning base repository..."
if ! git clone https://github.com/pirati-cz/gapi.git $IDIR ; then
    err "Cloning failed."
    exit 1
fi

# build Docker gapi image?
if ask "Do you want build gapi Docker image?" Y; then
cd $IDIR/core
./build_image.sh
fi

# system user
msg "In GAPI we use user 'app' (uid: 9999) and group 'app' (gid: 9999)."

if ask "Do you want create group 'app' with gid 9999?" Y; then
groupadd -g 9999 app
fi

if ask "Do you want create user 'app' with uid 9999?" Y; then
useradd -u 9999 app
fi

if ask "Do you want add your user $(whoami) into 'app' gorup?" Y; then
usermod -G app -a $(whoami)
fi

msg "You can now run gapi Docker container via 'gapi.sh' bash script. Run ./gapi.sh for usage."
msg "Have a nice graphing!"
exit 0


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
    echo $1
}
function err {
    echo -ne "\e[0;91m\e[40m >>> \e[m "
    echo $1   
}

splash

PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #"
DIR="$PATH/core"

# check arguments
if [ ! -z "$1" ]; then
    DIR="$1"
fi
# absolute path test
if [[ $DIR != /* ]] ; then
    DIR="$PATH/$DIR"
fi

# create target directory and cd there
msg "Create install directory... $DIR"
if mkdir -p "$DIR" ; then
    cd $DIR
else
    err "Creating directory failed."
    exit 1;
fi

# clone base
msg "Cloning base repository..."
if ! git clone https://github.com/pirati-cz/gapi.git $DIR ; then
    err "Cloning failed."
    exit 1;
fi

# create other directories
msg "Create useful direcories..."
mkdir -p $DIR/app
mkdir -p $DIR/data/db

# build Docker gapi image?
msg "Do you want build gapi Docker image? (y/n)"
read BUILD_IMAGE
if [[ $BUILD_IMAGE == "y" ]] ; then
./core/build_image.sh
fi

# system user
msg "In GAPI we use user 'app' (uid: 9999) and group 'app' (gid: 9999)."
msg "Do you want create group 'app' with gid 9999? (y/n)"
read GROUP
if [[ $GROUP == "y" ]]; then
groupadd -g 9999 app
fi
msg "Do you want create user 'app' with uid 9999? (y/n)"
read USER
if [[ $USER == "y" ]]; then
useradd -u 9999 app
fi
msg "Do you want add your user $(whoami) into 'app' gorup? (y/n)"
read ADDG
if [[ $ADDG == "y" ]]; then
usermod -G app -a $(whoami)
fi

msg "You can now run gapi Docker container via 'gapi.sh' bash script. Run ./gapi.sh for usage."
msg "Have a nice graphing!"
exit 0


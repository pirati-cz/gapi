#!/bin/bash

function splash {
    echo ""
    echo -e "\e[0;32m\e[40m                                                     \e[0m"
    echo -e "\e[0;32m\e[40m      GAPI - Graph Application Programming Interface \e[0m"
    echo -e "\e[0;32m\e[40m      major version: 1.0a                            \e[0m"
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

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #"
DIR="$DIR/core"

# check arguments
if [ ! -z "$1" ]; then
    DIR="$1"
fi

# absolute path test
if [[ $DIR != /* ]] ; then
    err "Path of install directory must be absolute."
    exit 1;
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
mkdir -p $DIR/ssh

# clone repositories
msg "Cloning other repositories..."
cd $DIR/app
#git clone https://github.com/pirati-cz/graph-common.git graph-common
#git clone https://github.com/pirati-cz/graph-cli.git graph-cli
#git clone https://github.com/pirati-cz/graph-rest.git graph-rest
cd $DIR

# generate ssh key
msg "Generate ssh keys into virtual machine..."
#./generate_ssh_key.sh

# container environment for 'app' user
msg "Installing Docker environment..."
#echo 'source /etc/container_environment.sh' > $DIR/app/.bashrc

msg "Have a nice graphing!"
exit 0

#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #"
if [ ! -z "$1" ]; then
    DIR="$1"
fi

# directory paths
APP_SSH_DIR="$DIR/app/.ssh"
SSH_DIR="$DIR/ssh"

# create target directories
mkdir -p --mode 0700 $SSH_DIR
mkdir -p --mode 0700 $APP_SSH_DIR

# generate key
ssh-keygen -t rsa -f $SSH_DIR/id_rsa

# move public key to app/.ssh/authorized_keys to allow ssh into the container
mv $SSH_DIR/id_rsa.pub $APP_SSH_DIR/authorized_keys

exit 0



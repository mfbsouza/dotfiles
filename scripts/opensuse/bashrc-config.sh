#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN Configuring bashrc... $CLEAR"

cat $HOME/workspace/dotfiles/bashrc.template >> $HOME/.bashrc

echo -e "$GREEN Done! $CLEAR"

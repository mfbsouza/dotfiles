#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [bashrc] Configuring bashrc... $CLEAR"

cat $HOME/workspace/dotfiles/bashrc.template >> $HOME/.bashrc

echo -e "$GREEN [bashrc] Done! $CLEAR"

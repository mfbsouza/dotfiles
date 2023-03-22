#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo ""
echo -e "$GREEN Configuring bashrc... $CLEAR"
echo ""

head -n 9 $HOME/workspace/dotfiles/bashrc.template >> $HOME/.bashrc

echo ""
echo -e "$GREEN Creating ~/bin folder... $CLEAR"
echo ""

mkdir -p ~/bin

echo ""
echo -e "$GREEN Done! $CLEAR"
echo ""

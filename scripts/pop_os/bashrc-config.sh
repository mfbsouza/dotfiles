#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo ""
echo -e "$GREEN Configuring bashrc... $CLEAR"
echo ""

cat $HOME/workspace/dotfiles/bashrc.template >> $HOME/.bashrc

echo ""
echo -e "$GREEN Done! $CLEAR"
echo ""

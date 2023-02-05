#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo ""
echo -e "$GREEN Creating soft links to perf scripts in $HOME/bin... $CLEAR"
echo ""

mkdir -p $HOME/bin
ln -s $HOME/workspace/dotfiles/scripts/perf_tweaks/overclock-rx580.sh $HOME/bin
ln -s $HOME/workspace/dotfiles/scripts/perf_tweaks/perf_governor.sh $HOME/bin

echo ""
echo -e "$GREEN Done! $CLEAR"
echo ""

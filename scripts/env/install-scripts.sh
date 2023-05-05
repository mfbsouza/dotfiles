#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [scripts] Creating soft links to perf scripts in $HOME/bin... $CLEAR"

mkdir -p $HOME/bin
ln -s $HOME/workspace/dotfiles/scripts/perf_tweaks/perf_governor.sh $HOME/bin

echo -e "$GREEN [scripts] Done! $CLEAR"

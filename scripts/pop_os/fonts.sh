#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo ""
echo -e "$GREEN Installing Inconsolata Nerd Fonts... $CLEAR"
echo ""

mkdir fonts && cd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Inconsolata.zip
unzip Inconsolata.zip
mkdir -p ~/.fonts
cp -r *.ttf ~/.fonts
cd ..
rm -rf fonts
fc-cache -fv

echo ""
echo -e "$GREEN Done! $CLEAR"
echo ""

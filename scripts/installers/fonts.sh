#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [nerd fonts] Installing Inconsolata Nerd Fonts... $CLEAR"

# tmp work folder
mkdir -p /tmp/fonts
cd /tmp/fonts

# download
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Inconsolata.zip
unzip Inconsolata.zip

# "install it"
mkdir -p ~/.fonts
cp -r *.ttf ~/.fonts
fc-cache -fv

# move back to last folder
cd -

echo -e "$GREEN [nerd fonts] Done! $CLEAR"

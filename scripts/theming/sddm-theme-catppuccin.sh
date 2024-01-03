#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [catppuccin theme for SDDM] Installing... $CLEAR"

# clone the source
git clone https://github.com/catppuccin/sddm.git /tmp/sddm

# install
cd /tmp/sddm/src/
sudo cp -r catppuccin-mocha /usr/share/sddm/themes/

# go back to last folder
cd -

echo -e "$GREEN [catppuccin theme for SDDM] Done! $CLEAR"

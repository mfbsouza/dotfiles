#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [catppuccin theme for KDE plasma] Installing... $CLEAR"

# clone the source
git clone --depth=1 https://github.com/catppuccin/kde.git /tmp/catppuccin-kde

# install
cd /tmp/catppuccin-kde
./install.sh

# go back to last folder
cd -

echo -e "$GREEN [catppuccin theme for KDE plasma] Done! $CLEAR"

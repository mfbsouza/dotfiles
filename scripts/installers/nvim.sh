#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [neovim] Installing... $CLEAR"

# clone the source
git clone -b stable https://github.com/neovim/neovim /tmp/neovim

# dependencies: ninja-build gettext cmake unzip curl

# build
cd /tmp/neovim
make CMAKE_BUILD_TYPE=Release

# install
sudo make install

# go back to last folder
cd -

echo -e "$GREEN [neovim] Done! $CLEAR"

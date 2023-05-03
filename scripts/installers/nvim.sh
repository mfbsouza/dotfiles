#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

echo -e "$GREEN [Neovim] Installing... $CLEAR"

# make temp working directory
mkdir /tmp/nvim
cd /tmp/nvim

# clone the source
git clone -b stable https://github.com/neovim/neovim

# build
cd neovim
make CMAKE_BUILD_TYPE=Release

# install
sudo make install

# go back to last folder
cd -

echo -e "$GREEN [Neovim] Done! $CLEAR"

#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [vkbasalt] Installing... $CLEAR"

# clone the source
git clone https://github.com/DadSchoorse/vkBasalt.git /tmp/vkbasalt

# dependencies: spirv-headers

# build and install
cd /tmp/vkbasalt
meson setup --buildtype=release --prefix=/usr builddir
ninja -C builddir install

# go back to last folder
cd -

echo -e "$GREEN [vkbasalt] Done! $CLEAR"

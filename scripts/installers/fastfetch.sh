#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [fastfetch] Installing... $CLEAR"

# clone the source
git clone -b master https://github.com/LinusDierheimer/fastfetch.git \
	/tmp/fastfetch
mkdir -p /tmp/fastfetch/build

# build
cd /tmp/fastfetch/build
cmake ..
cmake --build . --target fastfetch --target flashfetch

# install
sudo cmake --install . --prefix /usr/local

# go back to last folder
cd -

echo -e "$GREEN [fastfetch] Done! $CLEAR"

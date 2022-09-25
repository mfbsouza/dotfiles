#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "$GREEN Copying neovim config folder $CLEAR"
cp -r $SCRIPT_DIR/.config/nvim ~/.config/

echo "$GREEN Copying MangoHud config folder $CLEAR"
cp -r $SCRIPT_DIR/.config/MangoHud ~/.config/

echo "$GREEN Copying vkBasalt config folder $CLEAR"
cp -r $SCRIPT_DIR/.config/vkBasalt ~/.config/

echo "$GREEN Done. $CLEAR"


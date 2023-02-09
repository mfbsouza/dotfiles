#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo -e "$GREEN Copying gitconfig to home $CLEAR"
cp $SCRIPT_DIR/.gitconfig ~/

echo -e "$GREEN Copying neovim config folder $CLEAR"
cp -r $SCRIPT_DIR/.config/nvim ~/.config/

echo -e "$GREEN Copying MangoHud config folder $CLEAR"
cp -r $SCRIPT_DIR/.config/MangoHud ~/.config/

echo -e "$GREEN Copying vkBasalt config folder $CLEAR"
cp -r $SCRIPT_DIR/.config/vkBasalt ~/.config/

echo -e "$GREEN Done. $CLEAR"


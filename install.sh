#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo -e "$GREEN Linking gitconfig to home $CLEAR"
ln -s $SCRIPT_DIR/.gitconfig ~/.gitconfig

echo -e "$GREEN Linking tmux config to home $CLEAR"
ln -s $SCRIPT_DIR/.tmux.conf ~/.tmux.conf

echo -e "$GREEN Linking vimrc config to home $CLEAR"
ln -s $SCRIPT_DIR/.vimrc ~/.vimrc

echo -e "$GREEN Linking neovim config folder $CLEAR"
ln -s $SCRIPT_DIR/.config/nvim ~/.config/nvim

echo -e "$GREEN Linking MangoHud config folder $CLEAR"
ln -s $SCRIPT_DIR/.config/MangoHud ~/.config/MangoHud

echo -e "$GREEN Linking vkBasalt config folder $CLEAR"
ln -s $SCRIPT_DIR/.config/vkBasalt ~/.config/vkBasalt

echo -e "$GREEN Linking Neofetch config folder $CLEAR"
ln -s $SCRIPT_DIR/.config/neofetch ~/.config/neofetch

echo -e "$GREEN Done. $CLEAR"


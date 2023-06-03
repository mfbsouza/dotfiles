#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$ROOT_DIR/scripts

echo -e "$GREEN [dotfiles] $CLEAR"

echo -e "$GREEN Install Desktop or Server config files? [d/s] $CLEAR"
read ANSWER

echo -e "$GREEN Linking gitconfig to home $CLEAR"
ln -s $ROOT_DIR/.gitconfig ~/.gitconfig

echo -e "$GREEN Linking tmux config to home $CLEAR"
ln -s $ROOT_DIR/.tmux.conf ~/.tmux.conf

# config folders
mkdir -p ~/.config

echo -e "$GREEN Linking neovim config folder $CLEAR"
ln -s $ROOT_DIR/.config/nvim ~/.config/nvim

if [ "$ANSWER" == "d" ]; then

	echo -e "$GREEN Linking Alacritty config folder $CLEAR"
	ln -s $ROOT_DIR/.config/alacritty ~/.config/alacritty

	echo -e "$GREEN Linking i3wm config folder $CLEAR"
	ln -s $ROOT_DIR/.config/i3 ~/.config/i3

	echo -e "$GREEN Linking MangoHud config folder $CLEAR"
	ln -s $ROOT_DIR/.config/MangoHud ~/.config/MangoHud

	echo -e "$GREEN Linking vkBasalt config folder $CLEAR"
	ln -s $ROOT_DIR/.config/vkBasalt ~/.config/vkBasalt

	echo -e "$GREEN Install Nvidia Max Performance Service? [y/n] $CLEAR"
	read ANS
	if [ "$ANS" == "y" ]; then
		echo -e "$GREEN Linking systemd user services folder $CLEAR"
		ln -s $ROOT_DIR/.config/systemd ~/.config/systemd
		echo -e "$GREEN Enabling Nvidia Max Performance service $CLEAR"
		systemctl --user enable nvidia-max-perf.service
		echo -e "$GREEN Starting Nvidia Max Performance service $CLEAR"
		systemctl --user start nvidia-max-perf.service
	fi

	echo -e "$GREEN Install Intel GPU Tweaks? [y/n] $CLEAR"
	read ANS
	if [ "$ANS" == "y" ]; then
		echo dev.i915.perf_stream_paranoid=0 \
			| sudo tee -a /etc/sysctl.d/99-i915psp.conf
	fi

fi

echo -e "\n$GREEN [environment] $CLEAR"
$SCRIPT_DIR/./env/bashrc-config.sh
$SCRIPT_DIR/./env/install-scripts.sh

echo -e "\n$GREEN [programs] $CLEAR"
$SCRIPT_DIR/./installers/fastfetch.sh
$SCRIPT_DIR/./installers/fonts.sh
$SCRIPT_DIR/./installers/nvim.sh
$SCRIPT_DIR/./installers/rust.sh

echo -e "$GREEN Done! $CLEAR"


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

	echo -e "$GREEN Linking fonts folder $CLEAR"
	ln -s $ROOT_DIR/.fonts ~/.fonts
	fc-cache -fv

	echo -e "$GREEN Linking Alacritty config folder $CLEAR"
	ln -s $ROOT_DIR/.config/alacritty ~/.config/alacritty

	echo -e "$GREEN Linking MangoHud config folder $CLEAR"
	ln -s $ROOT_DIR/.config/MangoHud ~/.config/MangoHud

	echo -e "$GREEN Linking vkBasalt config folder $CLEAR"
	ln -s $ROOT_DIR/.config/vkBasalt ~/.config/vkBasalt

	echo -e "$GREEN Linking environment.d config folder $CLEAR"
	ln -s $ROOT_DIR/.config/environment.d ~/.config/environment.d

	echo -e "$GREEN Linking ssh-add.desktop to autostart $CLEAR"
	mkdir -p ~/.config/autostart
	ln -s $ROOT_DIR/.config/autostart/ssh-add.desktop \
		~/.config/autostart/ssh-add.desktop

	echo -e "$GREEN Linking systemd user services folder $CLEAR"
	ln -s $ROOT_DIR/.config/systemd/user/ssh-agent.service ~/.config/systemd/user/ssh-agent.service

	echo -e "$GREEN Enabling ssh-agent user service $CLEAR"
	systemctl --user enable ssh-agent.service

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
$SCRIPT_DIR/./installers/rust.sh
rm ~/.cargo/bin/rust-analyzer
$SCRIPT_DIR/./installers/rust-analyzer.sh
$SCRIPT_DIR/./installers/vkbasalt.sh
$SCRIPT_DIR/./installers/sddm-theme-catppuccin.sh
source ~/.bashrc
$SCRIPT_DIR/./installers/rust-apps.sh
$SCRIPT_DIR/./installers/plasma-theme-catppuccin.sh

echo -e "$GREEN Done! $CLEAR"


#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$ROOT_DIR/scripts

echo -e "$GREEN [dotfiles] $CLEAR"
mkdir -p ~/.config
mkdir -p ~/.config/environment.d

echo -e "$GREEN Install .gitconfig? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking gitconfig to home $CLEAR"
	ln -s $ROOT_DIR/.gitconfig ~/.gitconfig
fi

echo -e "$GREEN Install .tmux? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking tmux config to home $CLEAR"
	ln -s $ROOT_DIR/.tmux.conf ~/.tmux.conf
fi

echo -e "$GREEN Install neovim config? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking neovim config folder $CLEAR"
	ln -s $ROOT_DIR/.config/nvim ~/.config/nvim
fi

echo -e "$GREEN Install custom fonts? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking fonts folder $CLEAR"
	ln -s $ROOT_DIR/.fonts ~/.fonts
	fc-cache -fv
fi

echo -e "$GREEN Install alacritty config? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking Alacritty config folder $CLEAR"
	ln -s $ROOT_DIR/.config/alacritty ~/.config/alacritty
fi

echo -e "$GREEN Install MangoHud config? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking MangoHud config folder $CLEAR"
	ln -s $ROOT_DIR/.config/MangoHud ~/.config/MangoHud
fi

echo -e "$GREEN Install vkBasalt config? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking vkBasalt config folder $CLEAR"
	ln -s $ROOT_DIR/.config/vkBasalt ~/.config/vkBasalt
fi

echo -e "$GREEN Install ssh and git environment variables? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking environment configs to environment.d $CLEAR"
	ln -s $ROOT_DIR/.config/environment.d/ssh_auth_socket.conf \
		~/.config/environment.d/ssh_auth_socket.conf
	ln -s $ROOT_DIR/.config/environment.d/ssh_askpass.conf \
		~/.config/environment.d/ssh_askpass.conf
	ln -s $ROOT_DIR/.config/environment.d/git_askpass.conf \
		~/.config/environment.d/git_askpass.conf
fi

echo -e "$GREEN Install ssh-agent to autostart? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking ssh-add.desktop to autostart $CLEAR"
	mkdir -p ~/.config/autostart
	ln -s $ROOT_DIR/.config/autostart/ssh-add.desktop \
		~/.config/autostart/ssh-add.desktop
fi

echo -e "$GREEN Install ssh-agent systemd service? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking systemd user services folder $CLEAR"
	ln -s $ROOT_DIR/.config/systemd/user/ssh-agent.service \
		~/.config/systemd/user/ssh-agent.service

	echo -e "$GREEN Enabling ssh-agent user service $CLEAR"
	systemctl --user enable ssh-agent.service
fi

echo -e "$GREEN Install firefox wayland environment variable? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	ln -s $ROOT_DIR/.config/environment.d/firefox_wayland.conf \
		~/.config/environment.d/firefox_wayland.conf
fi

echo -e "$GREEN Install Intel GPU Tweaks? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo dev.i915.perf_stream_paranoid=0 \
		| sudo tee -a /etc/sysctl.d/99-i915psp.conf
fi

echo -e "$GREEN Install NVIDIA VAAPI config? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	ln -s $ROOT_DIR/.config/environment.d/nvidia_vaapi.conf \
		~/.config/environment.d/nvidia_vaapi.conf
fi

echo -e "$GREEN Install NVIDIA NVDEC config for mpv? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	mkdir -p ~/.config/mpv
	ln -s $ROOT_DIR/.config/mpv/mpv-nvidia.conf \
		~/.config/mpv/mpv.conf
fi

echo -e "$GREEN Install Intel VAAPI config for mpv? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	mkdir -p ~/.config/mpv
	ln -s $ROOT_DIR/.config/mpv/mpv-intel.conf \
		~/.config/mpv/mpv.conf
fi

echo -e "\n$GREEN [environment] $CLEAR"

echo -e "$GREEN Install bashrc config? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	$SCRIPT_DIR/./env/bashrc-config.sh
fi

echo -e "$GREEN Install scripts to the path? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	$SCRIPT_DIR/./env/install-scripts.sh
fi

echo -e "\n$GREEN [theming] $CLEAR"

echo -e "$GREEN Install sddm catppuccin theme? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	$SCRIPT_DIR/./installers/sddm-theme-catppuccin.sh
fi

echo -e "$GREEN Install plasma catppuccin theme? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	$SCRIPT_DIR/./installers/plasma-theme-catppuccin.sh
fi

echo -e "$GREEN Done! $CLEAR"

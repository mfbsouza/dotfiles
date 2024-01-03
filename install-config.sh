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

echo -e "$GREEN Install i3 config? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking i3 config folder $CLEAR"
	ln -s $ROOT_DIR/.config/i3 ~/.config/i3
fi

echo -e "$GREEN Install i3status config? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	echo -e "$GREEN Linking i3 config folder $CLEAR"
	ln -s $ROOT_DIR/.config/i3status ~/.config/i3status
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

echo -e "\n$GREEN [gnome settings] $CLEAR"

echo -e "$GREEN install firefox gnome theme? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
fi

echo -e "$GREEN set resize with right button? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
fi

echo -e "$GREEN configure nautilus-open-any-terminal? [y/n] $CLEAR"
read ANS
if [ "$ANS" == "y" ]; then
	gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty
	gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
	gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
	gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system
fi

echo -e "$GREEN Done! $CLEAR"

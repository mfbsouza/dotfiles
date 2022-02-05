#!/bin/bash

git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st

# dwm and st dependencies
sudo pacman -S xorg xorg-xinit xorg-xkill libx11 libxinerama libxft libxext

sudo pacman -S dmenu \
	lxappearance lxhotkey lxinput lxrandr lxtask \
	pcmanfm gvfs file-roller \
	network-manager-applet networkmanager-openvpn \
	xdg-user-dirs-gtk xdg-desktop-portal xdg-desktop-portal-gtk \
	pasystray pavucontrol \
	papirus-icon-theme

# compiling and installing dwm and st
cd dwm
make
sudo make install
cd ../st
make
sudo make install

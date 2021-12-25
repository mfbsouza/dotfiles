#!/bin/bash

sudo pacman -S gnome dconf-editor gnome-firmware xdg-desktop-portal \
	xdg-desktop-portal-gnome networkmanager-openvpn

yay -S chrome-gnome-shell --noconfirm

sudo systemctl enable gdm

# gsettings set
# org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
# org/gnome/desktop/peripherals/mouse/acceleration-profile
# terminal legacy header bar
# alt+tab


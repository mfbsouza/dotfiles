#!/bin/bash

sudo pacman -S xorg xorg-xinit xorg-xkill lxde network-manager-applet \
	networkmanager-openvpn gvfs file-roller xarchiver leafpad \
	gnome-screenshot xdg-user-dirs-gtk xdg-desktop-portal \
	xdg-desktop-portal-gtk pavucontrol papirus-icon-theme firefox

echo ""
echo "cp /etc/X11/xinit/xinitrc ~/.xinitrc; exec startlxde"
echo "background: #355481"
echo "bar: #14151F"
echo ""


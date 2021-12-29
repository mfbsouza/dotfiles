#!/bin/bash

sudo pacman -S gnome dconf-editor gnome-firmware xdg-desktop-portal \
	xdg-desktop-portal-gnome networkmanager-openvpn

yay -S chrome-gnome-shell --noconfirm

sudo systemctl enable gdm


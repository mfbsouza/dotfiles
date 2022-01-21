#!/bin/bash

sudo pacman -S chromium telegram-desktop mpv transmission-gtk obs-studio \
	kdenlive breeze breeze-gtk

yay -S discord_arch_electron --noconfirm

echo "sudo gpasswd -a user wireshark"


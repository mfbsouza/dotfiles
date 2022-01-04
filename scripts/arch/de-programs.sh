#!/bin/bash

sudo pacman -S telegram-desktop mpv transmission-gtk obs-studio \
	lm_sensors kdenlive breeze breeze-gtk wireshark-qt

yay -S google-chrome discord_arch_electron downgrade vgrep --noconfirm

echo "sudo gpasswd -a user wireshark"


#!/bin/bash

sudo pacman -S chromium telegram-desktop mpv transmission-gtk obs-studio \
	kdenlive breeze breeze-gtk wireshark-qt

yay -S discord_arch_electron downgrade vgrep --noconfirm

echo "sudo gpasswd -a user wireshark"


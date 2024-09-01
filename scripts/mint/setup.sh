#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'


echo -e "\n$GREEN Linux Mint personal setup script by mfbsouza $CLEAR\n"

sudo apt install tlp tlp-rdw vim git htop btop fd-find ripgrep stress zsh \
	tmux nodejs npm python3-pip xclip default-jre wireguard wireguard-tools \
	vainfo openssh-server virt-manager i3-wm i3lock i3status j4-dmenu-desktop \
	g++ clang bear lcov clang-format autoconf libtool

echo -e "\n$GREEN Done! $CLEAR\n"
exit 0

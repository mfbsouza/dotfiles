#!/bin/bash

echo "Installing AUR package manager..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

#!/bin/bash

echo "Installing WINE & DXVK for Windows Software..."

sudo pacman -S wine-staging lib32-giflib lib32-mpg123 lib32-openal lib32-v4l-utils lib32-libpulse opencl-icd-loader lib32-opencl-icd-loader lib32-libxslt lib32-libva lib32-gtk3 lib32-gst-plugins-base-libs lib32-sdl2 vkd3d lib32-vkd3d cups samba --noconfirm

yay -S dxvk-bin --noconfirm

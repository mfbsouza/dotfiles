#!/bin/bash

sudo pacman -S gnome gnome-tweaks gnome-firmware dconf-editor \
   xdg-desktop-portal xdg-desktop-portal-gtk networkmanager-openvpn \
   pipewire pipewire-pulse pipewire-alsa pipewire-jack lib32-pipewire \
   gst-libav gstreamer-vaapi gst-plugin-pipewire

yay -S chrome-gnome-shell --noconfirm

sudo systemctl enable gdm

echo ""
echo "if using laptop:"
echo "sudo pacman -S power-profiles-daemon"
echo "sudo systemctl enable power-profiles-daemon"
echo ""


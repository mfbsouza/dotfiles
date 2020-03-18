#!/bin/bash

echo "Setting up Audio drivers..."
sudo pacman -S pulseaudio-alsa alsa-utils alsa-plugins alsa-firmware --noconfirm

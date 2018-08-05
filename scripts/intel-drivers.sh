#!/bin/bash

echo "Installing Intel Graphics drivers..."
sudo pacman -S mesa lib32-mesa mesa-demos vulkan-intel vulkan-mesa-layer libva-intel-driver intel-media-driver beignet --noconfirm

#!/bin/bash

echo "Installing AMD Open Source Graphics drivers..."
sudo pacman -S mesa lib32-mesa mesa-demos xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon vulkan-mesa-layer libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau --noconfirm

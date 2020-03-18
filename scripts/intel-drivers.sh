#!/bin/bash

echo "Installing Intel Graphics drivers..."

sudo pacman -S mesa lib32-mesa mesa-demos\
	vulkan-intel\
	libva-intel-driver libva-utils\
       	intel-compute-runtime --noconfirm

#!/bin/bash

sudo pacman -S mesa lib32-mesa libva-mesa-driver lib32-libva-mesa-driver \
	vulkan-icd-loader lib32-vulkan-icd-loader vulkan-radeon lib32-vulkan-radeon \
	vulkan-tools mesa-demos clinfo libva-utils

yay -S opencl-amd --noconfirm


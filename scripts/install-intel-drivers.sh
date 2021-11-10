#!/bin/bash

sudo pacman -S mesa lib32-mesa intel-media-driver libvdpau-va-gl \
	vulkan-icd-loader lib32-vulkan-icd-loader vulkan-intel lib32-vulkan-intel \
	vulkan-tools mesa-demos clinfo libva-utils


#!/bin/bash

echo "Installing Vulkan Support..."
sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader\
       	vulkan-headers vulkan-validation-layers vulkan-tools --noconfirm

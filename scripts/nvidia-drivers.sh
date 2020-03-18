#!/bin/bash

echo "Installing Nvidia Graphics drivers..."
sudo pacman -S nvidia\
       	nvidia-utils lib32-nvidia-utils\
	nvidia-settings\
       	opencl-nvidia ocl-icd opencl-headers cuda --noconfirm

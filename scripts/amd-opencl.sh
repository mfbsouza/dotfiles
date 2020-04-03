#!/bin/bash

echo "Installing AMD OpenCL Drivers"
yay -S opencl-amd --noconfirm
sudo pacman -S ocl-icd opencl-headers --noconfirm

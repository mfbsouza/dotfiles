#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [tweaks - NVIDIA] Enabling NVIDIA DRM Modeset $CLEAR"

sudo kernelstub -a "nvidia-drm.modeset=1"

echo -e "$GREEN [tweaks - NVIDIA] Done! $CLEAR"

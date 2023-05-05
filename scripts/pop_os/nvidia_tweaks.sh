#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo "$GREEN [tweaks - NVIDIA] Enabling NVIDIA DRM Modeset $CLEAR"

sudo kernelstub -a "nvidia-drm.modeset=1"

echo "$GREEN [tweaks - NVIDIA] Done! $CLEAR"

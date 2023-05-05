#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo "$GREEN [tweaks - amdgpu] Enabling AMDGPU PP Feature Mask $CLEAR"

sudo kernelstub -a "amdgpu.ppfeaturemask=0xffffffff"

echo "$GREEN [tweaks - amdgpu] Done! $CLEAR"

#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo ""
echo "$GREEN Enabling AMDGPU PP Feature $CLEAR"
echo ""

sudo kernelstub -a "amdgpu.ppfeaturemask=0xffffffff"
sudo kernelstub -p

echo ""
echo "$GREEN Done! $CLEAR"
echo ""

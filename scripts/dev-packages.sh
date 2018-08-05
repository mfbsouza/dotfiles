#!/bin/bash

echo "Installing developer packages..."
sudo pacman -S git go clang cmake wget llvm openmp python-pip linux-headers sdl2 sdl2_gfx sdl2_image sdl2_mixer sdl2_net sdl2_ttf --noconfirm

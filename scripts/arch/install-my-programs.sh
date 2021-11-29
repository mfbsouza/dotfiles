#!/bin/bash

sudo pacman -S chromium telegram-desktop mpv transmission-gtk obs-studio \
	tree dmidecode wget neofetch screen man-db lm_sensors clang llvm openmp \
	python-pip vulkan-headers arm-none-eabi-gcc arm-none-eabi-newlib \
	avr-gcc avr-libc avrdude kdenlive breeze breeze-gtk

yay -S discord_arch_electron vgrep downgrade --noconfirm


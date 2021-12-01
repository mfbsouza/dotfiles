#!/bin/bash

sudo pacman -S tree dmidecode wget neofetch screen man-db clang llvm openmp \
	python-pip vulkan-headers arm-none-eabi-gcc arm-none-eabi-newlib \
	avr-gcc avr-libc avrdude

yay -S vgrep --noconfirm


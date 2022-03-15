#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sudo dnf -y install vulkan-tools python3-pip cmake gcc-c++ python3-devel bear

# backup
# vulkan-headers arm-none-eabi-gcc avr-gcc avrdude avr-libc

echo "open vim to download YCM with :PlugInstall and"
echo "$ cd ~/.vim/bundle/YouCompleteMe"
echo "$ python3 install.py --clangd-completer"

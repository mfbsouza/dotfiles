#!/bin/bash

# env

# packages
sudo apt install git ack picocom autoconf automake \
	gperf texinfo help2man libtool libtool-bin gawk \
	libncurses-dev meson ninja-build clang llvm \
	clang-format python3-pip cmake bear tree cscope \
	unzip nasm valgrind tmux clangd lcov golang \
	golang-golang-x-tools lua5.4 luajit neofetch htop \
	stress openssh-server gcc-avr avr-libc gdb-avr avrdude

# win32yank
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/

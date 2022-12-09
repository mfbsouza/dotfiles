#!/bin/bash

# env
echo "" >> ~/.bashrc
echo "# env" >> ~/.bashrc
echo "export WORKSPACE=$HOME/workspace" >> ~/.bashrc
echo "export CPPUTEST_HOME=$WORKSPACE/cpputest" >> ~/.bashrc
echo "export GOPATH=$HOME/.go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin" >> ~/.bashrc

# resource
source ~/.bashrc

# packages
sudo apt install git ack picocom autoconf automake \
	gperf texinfo help2man libtool libtool-bin gawk \
	libncurses-dev meson ninja-build clang llvm \
	clang-format python3-pip cmake bear tree cscope \
	unzip nasm valgrind tmux clangd lcov golang \
	golang-golang-x-tools neofetch htop stress docker \
	openssh-server gcc-avr avr-libc gdb-avr avrdude

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.cargo/bin/rust-analyzer
chmod +x ~/.cargo/bin/rust-analyzer
source ~/.bashrc

# gopls
go install golang.org/x/tools/gopls@latest

# win32yank
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/

# git

echo ""
echo "!!now manually configure git!!"
echo ""

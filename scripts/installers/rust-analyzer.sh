#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [rust-analyzer] Installing... $CLEAR"

curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.cargo/bin/rust-analyzer
chmod +x $HOME/.cargo/bin/rust-analyzer

echo -e "$GREEN [rust-analyzer] Done! $CLEAR"

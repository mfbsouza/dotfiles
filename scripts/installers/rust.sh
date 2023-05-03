#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

echo -e "$GREEN [Rust] Installing... $CLEAR"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo -e "$GREEN [Rust] Done! $CLEAR"

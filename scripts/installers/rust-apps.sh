#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [rust apps] Installing... $CLEAR"

cargo install ripgrep bat

echo -e "$GREEN [rust apps] Done! $CLEAR"
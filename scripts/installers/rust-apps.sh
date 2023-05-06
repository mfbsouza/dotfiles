#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

echo -e "$GREEN [ripgrep] Installing... $CLEAR"

cargo install ripgrep bat

echo -e "$GREEN [ripgrep] Done! $CLEAR"

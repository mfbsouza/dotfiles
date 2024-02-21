#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN [default apps] Configuring default apps... $CLEAR"

xdg-mime default gpicview.desktop image/png
xdg-mime default gpicview.desktop image/jpeg
xdg-mime default thunar.desktop inode/directory

echo -e "$GREEN [default apps] Done! $CLEAR"

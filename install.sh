#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Copying vimrc"
cp $SCRIPT_DIR/.vimrc ~/.vimrc

echo "Copying MangoHud config folder"
cp -r $SCRIPT_DIR/.config/MangoHud ~/.config/

echo "Copying vkBasalt config folder"
cp -r $SCRIPT_DIR/.config/MangoHud ~/.config/

echo "Done."


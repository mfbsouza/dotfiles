#!/bin/bash

#mfbsouza's shell script for setting up dotfiles

dotfiles=(".bashrc .bash_profile")
configs=("mpv" "MangoHud")

config_dir="${PWD}/.config"
dir="${PWD}"

echo "creating dotfiles..."
#installing dotfiles
for dotfile in "${dotfiles[@]}";do
	ln -sf "${dir}/${dotfile}" "${HOME}/${dotfile}"
done

echo "creating .config/ files..."
#installing config files
for config in "${configs[@]}";do
	ln -sf "${config_dir}/${config}" "${HOME}/.config/${config}"
done

echo "Finished creating files..."

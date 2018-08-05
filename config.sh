#!/bin/bash

#PunishedBois shell script for setting up dotfiles

dotfiles=(".tmux.conf" ".w3m" ".gitconfig" ".vimrc" ".vim" ".bashrc")
configs=("htop" "neofetch" "nvim")

config_dir="${HOME}/dotfiles/.config"
dir="${HOME}/dotfiles"

#copy bashrc to root user
sudo cp "${dir}/.bashrc" "/root/"

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
echo "Check me out for more stuff in github.com/mfbsouza"

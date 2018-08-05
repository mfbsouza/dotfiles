#!/bin/bash

#PunishedBois shell script for removing system links

dotfiles=(".tmux.conf" ".w3m" ".gitconfig" ".vimrc" ".vim" ".bashrc")
configs=("htop" "neofetch" "nvim")

config_dir="${HOME}/dotfiles/.config"
dir="${HOME}/dotfiles"

#remove bashrc from root user
sudo rm /root/.bashrc

echo "removing dotfiles..."
#removing dotfiles
for dotfile in "${dotfiles[@]}";do
	rm -rf "${HOME}/${dotfile}"
done

echo "removing .config/ dotfiles..."
#removing config files
for config in "${configs[@]}";do
	rm -rf "${HOME}/.config/${config}"
done

echo "finished removing files..."
echo "Check me out for more stuff in github.com/mfbsouza"

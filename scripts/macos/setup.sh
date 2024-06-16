#!/bin/zsh

# packages
echo "Installing basic packages..."
brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting
brew install --cask font-inconsolata-nerd-font
brew install fd ripgrep tmux neovim python pyenv pyenv-virtualenv node go gpg pinentry-mac

# this might have a problem if using apple silicon
echo "Install desktop apps? [y/N]"
read ANS
if [ "$ANS" == "y" ]; then
	brew install --cask slack spotify postman visual-studio-code zoom webex
fi

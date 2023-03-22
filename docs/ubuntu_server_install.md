# My Ubuntu Server install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Configure SSH Key authentication

	[Doc about ssh key auth](https://github.com/mfbsouza/docs/blob/main/docs/ssh-key.md)

## Clone dotfiles repo

	$ mkdir workspace && cd workspace
	$ git clone https://github.com/mfbsouza/dotfiles.git
	$ cd dotfiles/scripts/server

## Configure Bashrc

	$ ./bashrc-config.sh

**reopen terminal at the same folder as previous!**

## Install Packages

	$ ./packages.sh

## Install Dotfiles configs

	$ cd ../../ && ./install.sh


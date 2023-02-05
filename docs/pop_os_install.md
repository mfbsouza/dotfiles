# My Pop OS workstation install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Hostname

	$ set hostnamectl set-hostname HOSTNAME_HERE

## Clone dotfiles repo

	$ sudo zypper in git
	$ mkdir workspace && cd workspace
	$ git clone https://github.com/mfbsouza/dotfiles.git
	$ cd dotfiles/scripts/opensuse

## Configure Git

	$ git config --global user.name "username"
	$ git config --global user.email "user@email.com"
	$ git config --global core.editor "editor"
	$ git config --global credential.helper store

## Configure Kernel Parameters

	$ ./amdgpu_featuremask.sh

## Configure Gnome

	$ ./gnome.sh

## Configure Bashrc

	$ ./bashrc-config.sh

## Install Fonts

	$ ./fonts.sh

**reopen terminal at the same folder as previous!**

## Install Packages

	$ ./packages.sh

## Install Perf Tweaks Scripts

	$ ./install-scripts.sh

## Install Dotfiles configs

	$ cd ../../ && ./install.sh


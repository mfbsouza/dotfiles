# My Pop OS workstation install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Clone dotfiles repo

	$ mkdir workspace && cd workspace
	$ git clone https://github.com/mfbsouza/dotfiles.git
	$ cd dotfiles/scripts/pop_os

## Configure Kernel Parameters (amdgpu only)

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


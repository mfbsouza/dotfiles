# My Pop OS workstation install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Set up ssh and gpg keys

    $ sudo apt install openssh-server

- [SSH Keys](https://github.com/mfbsouza/docs/blob/main/docs/ssh-key.md)
- [GPG Keys](https://github.com/mfbsouza/docs/blob/main/docs/gpg-key.md)

## Clone dotfiles repo

	$ mkdir workspace && cd workspace
	$ git clone git@github.com:mfbsouza/dotfiles.git
	$ cd dotfiles

## install build dependencies

    $ sudo apt install ninja-build gettext cmake

## install it

    $ ./install.sh

**reopen terminal at the same folder as previous!**

## Install Packages

	$ ./scripts/pop_os/packages.sh

## Configure Gnome

    $ ./scripts/pop_os/gnome.sh

## Configure GPU tweaks

for NVIDIA GPUS:

	$ ./scripts/pop_os/nvidia_tweaks.sh

for AMD GPUS:

	$ ./scripts/pop_os/amdgpu_tweaks.sh

for Intel GPUS:

    $ ./scripts/perf_tweaks/intel_gpu_tweak.sh

## Fist time nvim setup

open nvim and do TSUpdate

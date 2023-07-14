#!/bin/bash

FILE=/etc/udev/rules.d/00-remove-nvidia.rules

if [ $# -gt 0 ]; then

	if [ "$1" = "nvidia" ]; then
		echo "enabling nvidia graphics on next boot..."
		if [ ! -f "$FILE" ]; then
			echo "nvidia graphics already enabled!"
			exit 0
		else
			sudo rm /etc/udev/rules.d/00-remove-nvidia.rules
			sudo cp /home/$USER/bin/nvidia-switch/arch-nvidia.conf \
				/boot/loader/entries/arch_linux.conf
			echo "nvidia graphics enabled on next boot!"
			exit 0
		fi

	elif [ "$1" = "intel" ]; then
		echo "disabling nvidia graphics..."
		if [ -f "$FILE" ]; then
			echo "nvidia graphics already disabled!"
			exit 0
		else
			sudo cp /home/$USER/bin/nvidia-switch/00-remove-nvidia.rules \
				/etc/udev/rules.d/00-remove-nvidia.rules
			sudo cp /home/$USER/bin/nvidia-switch/arch-intel.conf \
				/boot/loader/entries/arch_linux.conf
			echo "nvidia graphics disabled on next boot!"
			exit 0
		fi

	else
		echo "Errror: option '$1' not recognized"
		echo "Syntax: nvidia-switch [nvidia/intel]"
	fi

else
	echo "Error: expected more command line arguments"
	echo "Syntax: nvidia-switch [nvidia/intel]"
fi

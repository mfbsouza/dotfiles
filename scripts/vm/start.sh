#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Error: No arguments where given"
	echo "Syntax: ./start-vm.sh <path_to_disk.img>"
	echo "Syntax: ./start-vm.sh <path_to_disk.img> <path_to_iso.iso>"
	exit 1
fi

# qemu system config

BOARD=pc
SOCKET=1
CORE=4
THRDS_PER_CORE=1
MEM=4G

# cmd
qemu-system-x86_64 \
	-machine type=$BOARD,accel=kvm \
	-cpu host -smp sockets=$SOCKET,cores=$CORE,threads=$THRDS_PER_CORE \
	-m $MEM \
	-vga virtio \
	-display sdl,gl=on \
	-boot menu=on \
	-device virtio-net,netdev=vmnic \
	-netdev user,id=vmnic,hostfwd=tcp:127.0.0.1:2222-:22 \
	-drive file=$1,if=virtio,format=raw \
	-drive file=$2,media=cdrom

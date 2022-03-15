#!/bin/bash

sudo dnf group install --with-optional virtualization
sudo dnf install qemu-system-arm qemu-system-aarch64 qemu-system-riscv
sudo systemctl enable --now libvirtd

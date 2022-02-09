#!/bin/bash

sudo dnf group install --with-optional virtualization
sudo systemctl enable --now libvirtd

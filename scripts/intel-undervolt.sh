#!/bin/bash

yay -S intel-undervolt --noconfirm
sudo intel-undervolt read
sudo nano /etc/intel-undervolt.conf
sudo intel-undervolt apply
sudo systemctl enable intel-undervolt.service

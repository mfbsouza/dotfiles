#!/bin/bash

git clone https://github.com/kitsunyan/intel-undervolt.git
cd intel-undervolt
./configure --enable-systemd && make && sudo make install
sudo nano /etc/intel-undervolt.conf
sudo intel-undervolt apply
sudo systemctl enable intel-undervolt
cd ..
rm -rf intel-undervolt

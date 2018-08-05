#!/bin/bash

echo "Installing MangoHud for Game Monitoring & FPS Limit..."

git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git
cd MangoHud
./build.sh install

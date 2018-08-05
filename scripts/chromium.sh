#!/bin/bash

echo "Installing Chromium with HW Accel Support..."
yay -S chromium-vaapi-bin --noconfirm
yay -S chromium-widevine --noconfirm

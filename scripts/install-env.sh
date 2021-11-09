#!/bin/bash

echo "MOZ_X11_EGL=1" | sudo tee -a /etc/environment
echo "MOZ_WEBRENDER=1" | sudo tee -a /etc/environment
echo "MESA_DISK_CACHE_SINGLE_FILE=1" | sudo tee -a /etc/environment

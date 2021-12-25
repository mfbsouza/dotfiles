#!/bin/bash

sudo pacman -S pipewire lib32-pipewire pipewire-media-session \
	pipewire-alsa pipewire-pulse pipewire-jack pipewire-v4l2 \
	pipewire-zeroconf gstreamer gst-plugins-base gst-plugins-bad \
	gst-plugin-pipewire gstreamer-vaapi gst-libav


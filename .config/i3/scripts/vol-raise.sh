#!/bin/bash

pactl set-sink-volume @DEFAULT_SINK@ +10% && killall -SIGUSR1 i3status

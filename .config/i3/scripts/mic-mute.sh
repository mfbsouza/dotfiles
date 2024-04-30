#!/bin/bash

pactl set-source-mute @DEFAULT_SOURCE@ toggle && killall -SIGUSR1 i3status

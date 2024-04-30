#!/bin/bash

maim --window $(xdotool getactivewindow) "$HOME/Pictures/screenshot-$(date '+%F-%T').png"

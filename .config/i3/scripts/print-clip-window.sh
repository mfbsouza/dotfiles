#!/bin/bash

maim --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png

#!/bin/bash

# new voltages for P-state 7
echo "s 7 1424 1150" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage

# apply
echo "c" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage

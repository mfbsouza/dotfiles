#!/bin/bash

# new voltages for P-state 4,5,6 and 7
echo "s 4 1215 1100" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage
echo "s 5 1257 1100" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage
echo "s 6 1300 1100" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage
echo "s 7 1370 1100" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage

# apply
echo "c" | sudo tee /sys/class/drm/card0/device/pp_od_clk_voltage

#!/bin/sh
if [ "$1" = "post" ]; then
    modprobe -r i2c_hid_acpi
    sleep 1
    modprobe i2c_hid_acpi
fi


#!/bin/sh
# If the lid state file contains "open", exit with success (0)
if grep -q "open" /proc/acpi/button/lid/*/state; then
    exit 0
else
    # Lid is closed, exit with failure (1)
    exit 1
fi

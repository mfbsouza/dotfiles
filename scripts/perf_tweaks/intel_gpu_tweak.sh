#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo dev.i915.perf_stream_paranoid=0 | sudo tee -a /etc/sysctl.d/99-i915psp.conf
echo -e "$GREEN Done! $CLEAR"

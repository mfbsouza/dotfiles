#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

echo -e "$GREEN [Proton-GE] Installing... $CLEAR"

# script copied from
# github.com/GloriousEggroll/proton-ge-custom#installation

# make temp working directory
mkdir /tmp/proton-ge-custom
cd /tmp/proton-ge-custom

# download tarball 
curl -sLOJ $(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep browser_download_url | cut -d\" -f4 | egrep .tar.gz)

# download checksum 
curl -sLOJ $(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep browser_download_url | cut -d\" -f4 | egrep .sha512sum) 

# check tarball with checksum
sha512sum -c *.sha512sum
# if result is ok, continue

# make steam directory if it does not exist
mkdir -p ~/.steam/root/compatibilitytools.d

# extract proton tarball to steam directory
tar -xf GE-Proton*.tar.gz -C ~/.steam/root/compatibilitytools.d/

# going back to last folder
cd -

echo -e "$GREEN [Proton-GE] Done! $CLEAR"
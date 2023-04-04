#!/bin/bash
#=================================================
# File name: preset-speedtest-cli.sh
# Usage: preset-speedtest-cli.sh $platform
# System Required: Linux
# Lisence: MIT
# Author: Helmi Amirudin <https://www.helmiau.com>
# Source: Speedtest by Ookla <https://www.speedtest.net/apps/cli> (scroll down until u find "Linux" under "Download Speedtest CLI" section.
#=================================================

#=================================================
# platform lists informations
#=================================================
# armel = arm_arm (rpi1,2,orange pi zero)
# aarch64 = aarch64 (rpi3,4 nanopi r2c,r2s,r4s, orange pi r1 plus)
# x86_64 = x86_64
# i386 = i386
#=================================================

#=================================================
# URL format sample for aarch64 with speedtest version
#=================================================
# Always fetch latest version $(curl -s https://www.speedtest.net/apps/cli | sed -e "s|<a href=|\n|g" -e "s|class=|\n|g" | grep 'https://install.speedtest.net/app/cli/ookla-speedtest-.*.-linux' | cut -d'"' -f2 | grep ${1})

#=================================================
# Add SpeedTest CLI Core by Ookla
#=================================================
SPDTURL=$(curl -s https://www.speedtest.net/apps/cli | sed -e "s|<a href=|\n|g" -e "s|class=|\n|g" | grep 'https://install.speedtest.net/app/cli/ookla-speedtest-.*.-linux' | cut -d'"' -f2 | grep ${1})
SPDTGZ=$(echo -e "${SPDTURL}" | sed "s|https://install.speedtest.net/app/cli/||g")
SPDTDIR="files/bin"
SPDTBIN="speedtest"
echo -e "  Installing Speedtest Core by Ookla...."
echo -e "  Architecture detected : $1...."

# Check files/bin directory
if [[ ! -d $SPDTDIR ]]; then
	mkdir -p $SPDTDIR
fi

echo -e "  Downloading ${SPDTGZ}...."
wget -qO- $SPDTURL | tar xOvz > $SPDTDIR/$SPDTBIN
echo -e "  Installing...."

chmod +x $SPDTDIR/$SPDTBIN

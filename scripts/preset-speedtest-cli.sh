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
# Version: 1.1.0 <https://install.speedtest.net/app/cli/ookla-speedtest-1.1.0-aarch64-linux.tgz>
# Version: 1.1.1 <https://install.speedtest.net/app/cli/ookla-speedtest-1.1.1-linux-aarch64.tgz>
# Version: 1.2.0 <https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-i386.tgz>

#=================================================
# Add SpeedTest CLI Core by Ookla
#=================================================
SPDTVER="1.2.0"
SPDTURL="https://install.speedtest.net/app/cli/ookla-speedtest-$SPDTVER-linux-$1.tgz"
SPDTDIR="files/bin"
SPDTBIN="speedtest"
echo -e "  Installing Speedtest Core by Ookla...."
echo -e "  Architecture detected : $1...."

# Check files/bin directory
if [[ ! -d $SPDTDIR ]]; then
	mkdir -p $SPDTDIR
fi

echo -e "  Downloading ookla-speedtest-$SPDTVER-$1-linux.tgz...."
wget -qO- $SPDTURL | tar xOvz > $SPDTDIR/$SPDTBIN
echo -e "  Installing...."

chmod +x $SPDTDIR/$SPDTBIN

#!/bin/bash
#=================================================
# File name: preset-speedtest.sh
# Usage: <preset-speedtest.sh $platform> | example: <preset-speedtest.sh aarch64>
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: Helmi Amirudin <https://www.helmiau.com>
#=================================================

#=================================================
# platform lists informations
#=================================================
# arm = arm_arm (rpi1,2,orange pi zero)
# aarch64 = aarch64 (rpi3,4 nanopi r2c,r2s,r4s, orange pi r1 plus)
# x86_64 = x86_64
# i386 = i386
#=================================================

#https://install.speedtest.net/app/cli/ookla-speedtest-1.1.0-aarch64-linux.tgz
# Add SpeedTest Core by Ooklaa
SPEEDTESTVER="1.1.0"
SPEEDTESTURL="https://install.speedtest.net/app/cli/ookla-speedtest-$SPEEDTESTVER-$1-linux.tgz"
SPEEDTESTDIR="files/bin"
SPEEDTESTBIN="speedtest"
echo -e "  Installing Speedtest Core by Ooklaa...."
echo -e "  Architecture detected : $1...."

# Check etc/speedtest/bin directory
if [[ ! -d $SPEEDTESTDIR ]]; then
	mkdir -p $SPEEDTESTDIR
fi

echo -e "  Downloading ookla-speedtest-$SPEEDTESTVER-$1-linux.tgz...."
wget --show-progress -qO- $SPEEDTESTURL | tar xOvz > files/bin/speedtest
echo -e "  Installing...."

chmod +x $SPEEDTESTDIR/$SPEEDTESTBIN

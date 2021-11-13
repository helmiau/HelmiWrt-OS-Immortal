#!/bin/bash
#=================================================
# File name: preset-filebrowser.sh
# Usage: <preset-filebrowser.sh $platform> | example: <preset-v2raya.sh armv8>
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: Helmi Amirudin <https://www.helmiau.com>
#=================================================
# Platform List Informations
# Binary Name : linux-your_arch-filebrowser.tar.gz
#=================================================
# 386	= i386
# amd64	= x86_64
# arm64	= aarch64 (rpi 3,4)
# armv5	= 
# armv6	= arm_arm (rpi 1)
# armv7	= arm_cortex-a7 (orange pi, rpi 2)
#=================================================

# Download luci-app-filebrowser binary
[ ! -d files/root ] && mkdir -p files/root
echo -e "  Downloading linux-$1-filebrowser.tar.gz, installing...."
wget --show-progress -qO- https://github.com/filebrowser/filebrowser/releases/latest/download/linux-$1-filebrowser.tar.gz | tar xOvz > files/root/filebrowser
chmod +x files/root/filebrowser
#wget --show-progress -qO files/root/linux-filebrowser.tar.gz http://github.com/filebrowser/filebrowser/releases/latest/download/linux-$1-filebrowser.tar.gz
#[ -f files/root/linux-filebrowser.tar.gz ] && tar xOvz files/root/linux-filebrowser.tar.gz > files/root/filebrowser

#!/bin/bash
#=================================================
# File name: preset-v2raya.sh
# Usage: <preset-v2raya.sh $platform> | example: <preset-v2raya.sh armv8>
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: Helmi Amirudin <https://www.helmiau.com>
#=================================================

#=================================================
# platform lists informations
#=================================================
# arm32-v6 = arm_arm (rpi1,2)
# arm32-v7a = arm_cortex-a7 (orange pi)
# arm64-v8a = aarch64
# 64 = x86_64
# 32 = i386
#=================================================

# Add v2ray-core for v2rayA build
VAETCBIN="files/etc/v2raya/bin"
VUSRSHARE="files/usr/share/v2ray"
echo -e "${G}  Installing v2ray core by v2fly...."
echo -e "${G}  Architecture detected : ${R}$1....${Y}"
# Check etc/v2raya/bin directory
if [[ ! -d $VAETCBIN ]]; then
	mkdir -p $VAETCBIN
fi

version=$(curl -s https://api.github.com/repos/v2fly/v2ray-core/releases | jq -r .[].tag_name | head -1)
echo -e "  Downloading v2ray-linux-$1, installing...."
wget -qO $VAETCBIN/v2ray-core.zip "https://github.com/v2fly/v2ray-core/releases/download/$version/v2ray-linux-$1.zip"

#Check size v2ray-core.zip then symlink and set permissions
if [[ -s $VAETCBIN ]]; then
	echo -e "  $VABIN downloaded, installing...."
	unzip -d $VAETCBIN $VAETCBIN/v2ray-core.zip
	find $VAETCBIN -type f -name '*.json' -exec rm $VAETCBIN/*.json \;
	find $VAETCBIN -type f -name '*.dat' -exec rm $VAETCBIN/*.dat \;
	find $VAETCBIN -type f -name '*.zip' -exec rm $VAETCBIN/*.zip \;
	rm -rf $VAETCBIN/systemd
	echo -e "${G}  v2ray core by v2fly installed....${N}"
else
	echo -e "${R}  v2ray core by v2fly install failed....${N}"
fi
# Check usr/bin/v2raya directory
if [[ ! -d $VUSRSHARE ]]; then
	mkdir -p $VUSRSHARE
fi
# Downloading geoip files for v2ray core
if [[ -d $VUSRSHARE ]]; then
	VARULES="https://raw.githubusercontent.com/v2rayA/dist-v2ray-rules-dat/master"
	wget -O $VUSRSHARE/geosite.dat $VARULES/geosite.dat
	wget -O $VUSRSHARE/geoip.dat $VARULES/geoip.dat
	wget -O $VUSRSHARE/LoyalsoldierSite.dat $VARULES/geosite.dat
else
	echo -e "${R}  v2ray core by v2fly install failed....${N}"
fi

chmod +x $VAETCBIN/* $VUSRSHARE

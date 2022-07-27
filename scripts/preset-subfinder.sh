#!/bin/bash
#=================================================
# File name: preset-subfinder.sh
# Usage: preset-subfinder.sh $platform
# System Required: Linux
# Lisence: MIT
# Author: Helmi Amirudin <https://www.helmiau.com>
#=================================================
# Source: Subfinder by projectdiscovery <https://github.com/projectdiscovery/subfinder>.
# Source: bugscanner-go by aztecrabbit <https://github.com/aztecrabbit/bugscanner-go>.
#=================================================
#
#	Subfinder is a subdomain discovery tool that discovers valid subdomains for websites by using passive online sources.
#	It has a simple modular architecture and is optimized for speed.
#	subfinder is built for doing one thing only - passive subdomain enumeration, and it does that very well.
#
#	Bugscanner-go is useful tool for scanning a domain bug for Internet Freedom
#
#=================================================

#=================================================
# platform lists informations
#=================================================
# 386 = i386/x86 32bit/generic
# amd64 = x86 64bit
# arm64 = aarch64 (rpi3,4 nanopi r2c,r2s,r4s, orange pi r1 plus)
# armv5 = arm_arm (rpi1,2,orange pi zero)
# armv6 = arm_arm (rpi1,2,orange pi zero)
# armv7 = arm_arm (rpi1,2,orange pi zero)
#=================================================

#=================================================
# Add Subfinder binary
#=================================================
SUBFDR_TAG=$(curl -sL https://api.github.com/repos/helmiau/subfinder/releases | jq -r '.[0] | .tag_name' | sed 's/v//g')
SUBFDR_REL="https://github.com/helmiau/subfinder/releases/download/v${SUBFDR_TAG}/subfinder_${SUBFDR_TAG}_linux_$1.zip"
SUBFDR_PATH="files/bin"
SUBFDR_BIN="subfinder"

echo -e "  Installing Subfinder...."
echo -e "  Architecture detected : $1...."

# Check files/bin directory
if [[ ! -d $SUBFDR_PATH ]]; then
	mkdir -p $SUBFDR_PATH
fi

echo -e "  Downloading Subfinder v$SUBFDR_TAG for linux $1 architecture...."
wget -qO- "$SUBFDR_REL" | gunzip -c > $SUBFDR_PATH/$SUBFDR_BIN
echo -e "  Installing...."

chmod +x $SUBFDR_PATH/$SUBFDR_BIN
echo -e "  Done...."

#=================================================
# Add bugscanner-go binary
#=================================================
BUGSC_TAG=$(curl -sL https://api.github.com/repos/helmiau/bugscanner-go/releases | jq -r '.[0] | .tag_name' | sed 's/v//g')
BUGSC_REL="https://github.com/helmiau/bugscanner-go/releases/download/v${BUGSC_TAG}/bugscanner-go_${BUGSC_TAG}_linux_$1.zip"
BUGSC_PATH="files/bin"
BUGSC_BIN="bugscanner-go"

echo -e "  Installing bugscanner-go...."
echo -e "  Architecture detected : $1...."

# Check files/bin directory
if [[ ! -d $BUGSC_PATH ]]; then
	mkdir -p $BUGSC_PATH
fi

echo -e "  Downloading bugscanner-go v$BUGSC_TAG for linux $1 architecture...."
wget -qO- "$BUGSC_REL" | gunzip -c > $BUGSC_PATH/$BUGSC_BIN
echo -e "  Installing...."

chmod +x $BUGSC_PATH/$BUGSC_BIN
echo -e "  Done...."

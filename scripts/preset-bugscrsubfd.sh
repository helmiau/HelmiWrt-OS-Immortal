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

echo -e "  Preset: Bugscanner, Subfinder and Cloudflared Zerotrust Started...."

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
if [[ $1 == *"armv"* ]]; then
	sf_archie="armv6"
else
	sf_archie="$1"
fi
SUBFDR_TAG=$(curl -sL https://api.github.com/repos/projectdiscovery/subfinder/releases | jq -r '.[0] | .tag_name' | sed 's/v//g')
SUBFDR_REL="https://github.com/projectdiscovery/subfinder/releases/download/v${SUBFDR_TAG}/subfinder_${SUBFDR_TAG}_linux_${sf_archie}.zip"
SUBFDR_PATH="files/bin"
SUBFDR_BIN="subfinder"

echo -e "  Starting installation of Subfinder...."
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

echo -e "  Starting installation of bugscanner-go...."
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


#=================================================
# Cloudflare Zero Trust
#=================================================
# Read usage here https://github.com/helmiau/gegevps-openwrt-tools/tree/master/cloudflared
# Skip things around terminal installation, cause core, init and manager script alredy downloaded.
# You ONLY NEED to run "/root/cfdmgr e" command to edit your token.
#=================================================
# Supported platform lists
#=================================================
# arm = arm (rpi1,2)
# arm64 = aarch64 (pi 3,4)
# x86_64 = x86_64
# 386 = x86_generic
#=================================================

echo -e "  Starting Cloudflared Zerotrust Installation...."
cf_repo="cloudflare/cloudflared"
cf_bin="files/usr/bin/cloudflared"
cf_initd="files/etc/init.d/cloudflared"
cf_mgr="files/root/cfdmgr"
cf_gege="https://raw.githubusercontent.com/GegeDesembri/openwrt-tools/master/cloudflared"

# Github get latest version
cf_latest_bin=$(curl -s "https://api.github.com/repos/${cf_repo}/releases/latest" | jq -r .tag_name)

# Get device architecture
if [[ "$1" == *"arm64"* ]]; then
	cf_archie="arm64"
elif [[ "$1" == *"x86_64"* ]]; then
	cf_archie="amd64"
elif [[ "$1" == *"386"* ]]; then
	cf_archie="386"
elif [[ "$1" == *"armhf"* ]]; then
	cf_archie="armhf"
elif [[ "$1" == *"armv"* ]]; then
	cf_archie="arm"
else
	cf_archie="unsupported"
	echo -e "  Your device is unsupported cloudflared  Zero Trust!. Skipping..."
fi

if [[ ${cf_archie} != "unsupported" ]]; then
	# Make dir if not exist
	[[ ! -d files/usr/bin ]] && mkdir -p files/usr/bin
	[[ ! -d files/etc/init.d ]] && mkdir -p files/etc/init.d
	
	# Install Cloudflared
	echo -e "  Architecture detected: ${cf_archie}"
	wget -qO ${cf_bin} "https://github.com/${cf_repo}/releases/download/${cf_latest_bin}/cloudflared-linux-${cf_archie}"
	chmod +x ${cf_bin}

	# Install init.d
	wget -qO ${cf_initd} "${cf_gege}/cloudflared"
	chmod +x ${cf_initd}

	# Install CFD Manager
	wget -qO ${cf_mgr} "${cf_gege}/cfdmgr"
	chmod +x ${cf_mgr}
	echo -e "  Cloudflared  Zero Trust Installation Done...."
fi

echo -e "  Preset: Bugscanner, Subfinder and Cloudflared Zero Trust Done...."

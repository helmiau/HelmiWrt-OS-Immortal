#!/bin/bash
#=================================================
# File name: preset-clash-core.sh
# Usage: preset-clash-core.sh $platform
# System Required: Linux
# Lisence: MIT
# Author: SuLingGG, Helmi Amirudin
# Blog: https://helmiau.com
# Description: This script will install clash core kernel from Dreamacro or Meta or Vernesong
#=================================================
# Select core	: Remove # symbol from first word of wget line
# Unselect core	: Add # symbol at first word from wget line
#=================================================

# Initial recognition
COREDIR="files/etc/openclash/core"
APIGIT="https://api.github.com/repos"
mkdir -p $COREDIR

# TEST debug
# curl -sL https://api.github.com/repos/Dreamacro/clash/releases | grep /clash-linux-armv8 | awk -F '"' '{print $4}' | awk 'NR==1 {print; exit}'

# Vernesong Core has:
# - original core
# - tun premium core
# - tun game core
# - meta core <new>
# old clash_url=$(curl -sL $APIGIT/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-$1 | awk -F '"' '{print $4}')
# old clash_tun_url=$(curl -sL $APIGIT/vernesong/OpenClash/releases/tags/TUN-Premium | grep /clash-linux-$1 | awk -F '"' '{print $4}')
clash_url="https://raw.githubusercontent.com/vernesong/OpenClash/dev/core-lateset/dev/clash-linux-$1.tar.gz"
tun_core_ver=$(curl -sL https://raw.githubusercontent.com/vernesong/OpenClash/dev/core_version | awk -F: 'NR==2 {print $1}')
clash_tun_url="https://raw.githubusercontent.com/vernesong/OpenClash/dev/core-lateset/premium/clash-linux-$1-$tun_core_ver.gz"
clash_game_url=$(curl -sL $APIGIT/vernesong/OpenClash/releases/tags/TUN | grep /clash-linux-$1 | awk -F '"' '{print $4}')
clash_meta="https://raw.githubusercontent.com/vernesong/OpenClash/dev/core-lateset/meta/clash-linux-$1.tar.gz"
wget -qO- $clash_url | tar xOvz > $COREDIR/clash
wget -qO- $clash_tun_url | gunzip -c > $COREDIR/clash_tun
wget -qO- $clash_game_url | tar xOvz > $COREDIR/clash_game
wget -qO- $clash_meta | tar xOvz > $COREDIR/clash_meta_ofc

# Dreamacro Core has:
# - original core
# - tun premium core
clash_dreamacro=$(curl -sL $APIGIT/Dreamacro/clash/releases | grep /clash-linux-$1 | awk -F '"' '{print $4}' | sed -n '1p')
clash_tun_dreamacro=$(curl -sL $APIGIT/Dreamacro/clash/releases/tags/premium | grep /clash-linux-$1 | awk -F '"' '{print $4}')
wget -qO- $clash_dreamacro | gunzip -c > $COREDIR/clash_dreamacro
wget -qO- $clash_tun_dreamacro | gunzip -c > $COREDIR/clash_tun_dreamacro

# Clash Meta Core has:
# - tun premium core
# Docs: https://github.com/MetaCubeX/Clash.Meta/tree/Dev
# old clash_meta=$(curl -sL $APIGIT/MetaCubeX/Clash.Meta/releases | grep /Clash.Meta-linux-$1 | awk -F '"' '{print $4}' | sed -n '1p')
# wget -qO- $clash_meta | gunzip -c > $COREDIR/clash_meta

# Clash Meta Core WSS has:
# - tun premium core
# Docs: https://github.com/djoeni/Clash.Meta
APIGITWSS="https://api.github.com/repos/helmiau/Clash.Meta/releases/tags/Prerelease-WSS"
TAGWSS="Prerelease-WSS/Clash.Meta-linux"
if [[ $1 == "amd64" ]]; then
	clash_meta_wss_url=$(curl -sL $APIGITWSS | grep "$TAGWSS-amd64-efcf" | sed -e 's|"||g' -e 's| ||g' -e 's|browser_download_url:||g')
	clash_meta_wss_url_compat=$(curl -sL $APIGITWSS | grep "$TAGWSS-amd64-compatible" | sed -e 's|"||g' -e 's| ||g' -e 's|browser_download_url:||g')
elif [[ $1 == "armv8" ]]; then
	clash_meta_wss_url=$(curl -sL $APIGITWSS | grep "$TAGWSS-arm64" | sed -e 's|"||g' -e 's| ||g' -e 's|browser_download_url:||g')
else
	clash_meta_wss_url=$(curl -sL $APIGITWSS | grep "$TAGWSS-$1" | sed -e 's|"||g' -e 's| ||g' -e 's|browser_download_url:||g')
fi
echo -e "Download URL: $clash_meta_wss_url"
wget -qO- $clash_meta_wss_url | gunzip -c > $COREDIR/clash_meta
[ -f $COREDIR/clash_meta ] && ls -lh $COREDIR/clash_meta

if [[ $clash_meta_wss_url_compat =~ "amd64-compatible" ]]; then
	echo -e "Download URL: $clash_meta_wss_url_compat"
	wget -qO- $clash_meta_wss_url_compat | gunzip -c > $COREDIR/clash_meta_compat
	[ -f $COREDIR/clash_meta_compat ] && ls -lh $COREDIR/clash_meta_compat
fi

chmod +x $COREDIR/clash*

# Offline images sources
YACD="files/www/luci-static/resources/openclash"
mkdir -p $YACD
wget -qO "$YACD/Wiki.svg" "https://img.shields.io/badge/Wiki--lightgrey?logo=GitBook&style=social"
wget -qO "$YACD/Tutorials.svg" "https://img.shields.io/badge/Tutorials--lightgrey?logo=Wikipedia&style=social"
wget -qO "$YACD/Star.svg" "https://img.shields.io/badge/Star--lightgrey?logo=github&style=social"
wget -qO "$YACD/Telegram.svg" "https://img.shields.io/badge/Telegram--lightgrey?logo=Telegram&style=social"
wget -qO "$YACD/Sponsor.svg" "https://img.shields.io/badge/Sponsor--lightgrey?logo=ko-fi&style=social"

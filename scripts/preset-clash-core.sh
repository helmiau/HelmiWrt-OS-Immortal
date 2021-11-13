#!/bin/bash
#=================================================
# File name: preset-clash-core.sh
# Usage: <preset-clash-core.sh $platform> | example: <preset-clash-core.sh armv8>
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG, Helmi Amirudin
# Blog: https://mlapp.cn
#=================================================

mkdir -p files/etc/openclash/core

open_clash_premium_url=$(curl -sL https://api.github.com/repos/Dreamacro/clash/releases/tags/premium | grep /clash-linux-$1 | sed 's/.*url\": \"//g' | sed 's/\"//g')
open_clash_main_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-$1 | sed 's/.*url\": \"//g' | sed 's/\"//g')
# offical_clash_main_url=$(curl -sL https://api.github.com/repos/Dreamacro/clash/releases/tags/v1.3.5 | grep /clash-linux-$1 | sed 's/.*url\": \"//g' | sed 's/\"//g')
clash_tun_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN-Premium | grep /clash-linux-$1 | sed 's/.*url\": \"//g' | sed 's/\"//g')
clash_game_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN | grep /clash-linux-$1 | sed 's/.*url\": \"//g' | sed 's/\"//g')

wget --show-progress -qO- $open_clash_premium_url | gunzip -c > files/etc/openclash/core/clash
wget --show-progress -qO- $open_clash_main_url | tar xOvz > files/etc/openclash/core/clash_original
# wget --show-progress -qO- $offical_clash_main_url | gunzip -c > files/etc/openclash/core/clash
wget --show-progress -qO- $clash_tun_url | gunzip -c > files/etc/openclash/core/clash_tun
wget --show-progress -qO- $clash_game_url | tar xOvz > files/etc/openclash/core/clash_game

chmod +x files/etc/openclash/core/clash*

# Offline images sources
mkdir -p files/www/luci-static/resources/openclash
wget --show-progress -qO files/www/luci-static/resources/openclash/Tutorials.svg https://img.shields.io/badge/Tutorials--lightgrey?logo=Wikipedia&style=social
wget --show-progress -qO files/www/luci-static/resources/openclash/Star.svg https://img.shields.io/badge/Star--lightgrey?logo=github&style=social
wget --show-progress -qO files/www/luci-static/resources/openclash/Telegram.svg https://img.shields.io/badge/Telegram--lightgrey?logo=Telegram&style=social
wget --show-progress -qO files/www/luci-static/resources/openclash/Sponsor.svg https://img.shields.io/badge/Sponsor--lightgrey?logo=ko-fi&style=social

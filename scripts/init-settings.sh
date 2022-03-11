#!/bin/bash
#=================================================
# File name: init-settings.sh
# Description: This script will be executed during the first boot
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
#--------------------------------------------------------
#   If you use some codes frome here, please give credit to www.helmiau.com
#--------------------------------------------------------

# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/argon'

# Disable IPV6 ula prefix
sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# Check file system during boot
uci set fstab.@global[0].check_fs=1
uci commit

exit 0

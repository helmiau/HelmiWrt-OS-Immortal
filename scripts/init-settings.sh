#!/bin/bash
#=================================================
# File name: init-settings.sh
# Description: This script will be executed during the first boot
# Author: SuLingGG & helmiau
# Blog: https://mlapp.cn
#=================================================
#--------------------------------------------------------
#   If you use some codes frome here, please give credit to www.helmiau.com
#--------------------------------------------------------

# Apply your own customization on boot features
if grep -q "helmiwrt.sh" /boot/helmiwrt.sh; then
	logger "  helmilog : detected helmiwrt.sh boot script, running script..."
	echo -e "  helmilog : detected helmiwrt.sh boot script, running script..."
	chmod +x /boot/helmiwrt.sh
	./boot/helmiwrt.sh
	logger "  helmilog : helmiwrt.sh boot script running done!"
	echo -e "  helmilog : helmiwrt.sh boot script running done!"
fi

# HelmiWrt Patches
chmod +x /bin/helmiwrt
helmiwrt

# Run initial boot additions and add default interfaces
helmiwrt initboot
helmiwrt addinterfacefirewall

# auto fix for bcm27xx
if [ -e /bin/is_immortalwrt_based ] && grep -q "bcm27" /etc/openwrt_release; then
	helmiwrt fixov
fi

# Check file system during boot
uci set fstab.@global[0].check_fs=1
uci commit

exit 0

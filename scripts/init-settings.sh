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

# Set Timezone to Asia/Jakarta
uci set system.@system[0].timezone='WIB-7'
uci set system.@system[0].zonename='Asia/Jakarta'
uci commit system

# Bye-bye zh_cn
opkg remove $(opkg list-installed | grep zh-cn)

# Add ram checker from wegare123
# run "ram" using terminal to check ram usage
chmod +x /bin/ram

# Add fix download file.php for xderm and libernet
# run "fixphp" using terminal for use
chmod +x /bin/fixphp

# Add IP Address Info Checker
# run "myip" using terminal for use
chmod +x /bin/myip

# Add Samba Allowed Guest Setup
# run "sambaset" using terminal to set it up
chmod +x /bin/sambaset

# Add refresh IP Address for QMI Modems, such as LT4220
# Script by Rudi Hartono https://www.facebook.com/rud18
chmod +x /bin/ipqmi

# Fix luci-app-atinout-mod by 4IceG
chmod +x /usr/bin/luci-app-atinout

# Fix for xderm mini gui if trojan is not installed
ln -sf /usr/sbin/trojan /usr/bin/trojan

# HelmiWrt Patches
chmod +x /bin/helmiwrt
#helmiwrt

# Add default interfaces
helmiwrt addinterfacefirewall

# Set default theme to luci-theme-argon
# Delete default watchcat setting
# Set Google DNS as default DNS Forwarding
cat << 'EOF' > /bin/default-theme

uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

uci add_list dhcp.@dnsmasq[0].server='8.8.8.8'
uci add_list dhcp.@dnsmasq[0].server='8.8.4.4'
uci commit dhcp
/etc/init.d/dnsmasq restart

EOF
chmod +x /bin/default-theme
default-theme

# Added neofetch on oh-my-zsh
echo "neofetch" > /root/.oh-my-zsh/custom/example.zsh
chmod +x /bin/neofetch
neofetch

# Check file system during boot
uci set fstab.@global[0].check_fs=1
uci commit

exit 0

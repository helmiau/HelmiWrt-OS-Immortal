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

# Set default wifi name to HelmiWrt
sed -i "s#option ssid 'OpenWrt'#option ssid 'HelmiWrt'#iIg" /etc/config/wireless

# Bye-bye zh_cn
opkg remove $(opkg list-installed | grep zh-cn)

# start v2rayA service on boot
# sed -i "s#option enabled.*#option enabled '1'#g" /etc/config/v2raya
# /etc/init.d/v2raya enable
# /etc/init.d/v2raya start
# /etc/init.d/v2raya reload
# /etc/init.d/v2raya restart

# activate TUN TAP interface
/usr/sbin/openvpn --mktun --dev tun0
/usr/sbin/openvpn --mktun --dev tun1

# Apply your own customization on boot features
if grep -q "helmiwrt.sh" /boot/helmiwrt.sh; then
	logger "  helmilog : detected helmiwrt.sh boot script, running script..."
	echo -e "  helmilog : detected helmiwrt.sh boot script, running script..."
	chmod +x /boot/helmiwrt.sh
	./boot/helmiwrt.sh
	logger "  helmilog : helmiwrt.sh boot script running done!"
	echo -e "  helmilog : helmiwrt.sh boot script running done!"
fi

# Disable etc/config/xmm-modem on boot first
if [[ -f /etc/config/xmm-modem ]]; then
	logger "  helmilog : detected helmiwrt.sh boot script, running script..."
	echo -e "  helmilog : detected helmiwrt.sh boot script, running script..."
	sed -i "s#option enable.*#option enable '0'#g" /etc/config/xmm-modem
	logger "  helmilog : helmiwrt.sh boot script running done!"
	echo -e "  helmilog : helmiwrt.sh boot script running done!"
fi

# Set Custom TTL
cat << 'EOF' >> /etc/firewall.user

# Set Custom TTL
iptables -t mangle -I POSTROUTING -o  -j TTL --ttl-set 65
iptables -t mangle -I PREROUTING -i  -j TTL --ttl-set 65
ip6tables -t mangle -I POSTROUTING ! -p icmpv6 -o  -j HL --hl-set 65
ip6tables -t mangle -I PREROUTING ! -p icmpv6 -i  -j HL --hl-set 65

EOF
/etc/config/firewall restart

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
helmiwrt

# Add default interfaces
helmiwrt addinterfacefirewall

# HelmiWrt Patches
if ! grep -q "helmiwrt" /etc/rc.local; then
	sed -i 's#exit 0#\n#g' /etc/rc.local
	cat << 'EOF' >> /etc/rc.local

chmod +x /bin/helmiwrt
/bin/helmiwrt
exit 0
EOF
	logger "  helmilog : helmipatch already applied to on-boot..."
	echo -e "  helmilog : helmipatch already applied to on-boot..."
fi

# Other setup on start on-boot
cat << 'EOF' > /bin/default-theme

# Set Default Theme to Argon
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

# Set Google DNS as default DNS Forwarding
uci add_list dhcp.@dnsmasq[0].server='8.8.8.8'
uci add_list dhcp.@dnsmasq[0].server='8.8.4.4'
uci commit dhcp
/etc/init.d/dnsmasq restart


# Disable /etc/config/xmm-modem
uci set xmm-modem.@xmm-modem[0].enable='0'
uci commit

# Delete default watchcat setting
uci delete watchcat.@watchcat[0]
uci commit

# add cron job for modem rakitan
echo '#auto renew ip lease for modem rakitan' >> /etc/crontabs/root
echo '#30 3 * * * echo AT+CFUN=4 | atinout - /dev/ttyUSB1 - && ifdown mm && sleep 3 && ifup mm' >> /etc/crontabs/root
echo '#30 3 * * * ifdown fibocom && sleep 3 && ifup fibocom' >> /etc/crontabs/root
/etc/init.d/cron restart

# remove huawei me909s usb-modeswitch
sed -i -e '/12d1:15c1/,+5d' /etc/usb-mode.json

# remove dw5821e usb-modeswitch
sed -i -e '/413c:81d7/,+5d' /etc/usb-mode.json

EOF
chmod +x /bin/default-theme
default-theme

# Added neofetch on oh-my-zsh
echo "neofetch" > /root/.oh-my-zsh/custom/example.zsh
chmod +x /bin/neofetch
neofetch

# Fix 3ginfo
chmod +x /etc/init.d/3ginfo
chmod +x /usr/share/3ginfo/scripts/*
chmod +x /usr/share/3ginfo/cgi-bin/*

# Fix xdrtool: Xderm Mini Tool Script permission
chmod +x /bin/xdrtool

# Fix atinout permission
chmod +x /sbin/set_at_port.sh

# Fix sms tool
chmod +x /etc/init.d/smsled
chmod +x /sbin/cronsync.sh
chmod +x /sbin/set_sms_ports.sh
chmod +x /sbin/smsled-init.sh
chmod +x /sbin/smsled.sh

# Add wegare123 stl tool
# run "stl" using terminal for use
chmod +x /usr/bin/gproxy
chmod +x /usr/bin/stl
chmod +x /root/akun/tunnel.py
chmod +x /root/akun/ssh.py
chmod +x /root/akun/inject.py
chmod +x /usr/bin/autorekonek-stl
mkdir -p /root/.ssh/
touch /root/akun/ssl.conf
touch /root/.ssh/config
touch /root/akun/stl.txt
touch /root/akun/ipmodem.txt 

# Add wifi id seamless autologin by kopijahe
# run "kopijahe" using terminal for use
chmod +x /bin/kopijahe

# Fix telegrambot
chmod +x /etc/init.d/telegrambot
chmod -R +x /usr/lib/telegrambot/* /usr/lib/functions/*

# Fix nft-qos
chmod +x /etc/init.d/nft-qos
chmod -R +x /lib/nft-qos/*
chmod +x /etc/hotplug.d/dhcp/00-nft-qos-monitor
chmod +x /etc/hotplug.d/dhcp/01-nft-qos-dynamic

# Check file system during boot
uci set fstab.@global[0].check_fs=1
uci commit

exit 0

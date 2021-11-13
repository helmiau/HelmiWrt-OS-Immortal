#!/bin/bash
#=================================================
# File name: helmiwrt.sh
# Information: HelmiWrt OS custom script which run on first/initial boot
# Version: 1.0
# Author: Helmi Amirudin <https://www.helmiau.com>
#=================================================
# You can backup this file to your other storage/hdd/ or etc, then put it again to /boot/ directory after firmware burning
# Backup file ini ke penyimpanan lain yang anda miliki, lalu masukkan lagi ke direktori /boot/ setelah burning firmware
#=================================================

#=================================================
# Type your commands/scripts below
# Tulis informasi perintah dengan menggunakan contoh script dibawah ini
#=================================================
logger "  helmiwrt-bootlog : write your custom script information here !..."

#=================================================
# Some custom commands/scripts for Modem Rakitan (spt. LT4220, DW5821E)
# Beberapa kustomisasi perintah/skrip untuk Modem Rakitan (spt. LT4220, DW5821E)
#=================================================
#rm -rf /etc/hotplug.d/tty/25-modemmanager-tty
#echo "05c6 9026" >/sys/bus/usb/drivers/qmi_wwan/new_id

#=================================================
# Run your custom commands/scripts below
# Tuliskan kustomisasi script yang ingin anda gunakan di awal boot dibawah ini
#=================================================
echo -e "  helmiwrt-bootlog : write your custom script information here !..."

#=================================================
# Uninstall unused apps using sample script below / hapus aplikasi yang tidak digunakan dengan menggunakan beberapa contoh dari bawah ini
#=================================================
# - Download installed package list from https://github.com/helmiau/HelmiWrt-OS/releases
# - Unduh daftar paket terinstal dari https://github.com/helmiau/HelmiWrt-OS/releases
# opkg remove "package_name" # This line is only example / baris ini cuma contoh
#
# If you want to uninstall some packages, remove "#" symbol from first line
# Jika anda ingin menghapus aplikasi, hapus tanda "#" pada awal huruf di tiap baris yang ingin di uninstall
#
#opkg remove 3ginfo
#opkg remove 3ginfo-text
#opkg remove 6in4
#opkg remove adbyby
#opkg remove alpine-keys
#opkg remove alpine-repositories
#opkg remove antfs-mount
#opkg remove apk
#opkg remove aria2
#opkg remove ariang
#opkg remove ath9k-htc-firmware
#opkg remove atinout
#opkg remove automount
#opkg remove badvpn
#opkg remove bash
#opkg remove bind-dig
#opkg remove bind-host
#opkg remove bind-libs
#opkg remove blkid
#opkg remove boost
#opkg remove boost-date_time
#opkg remove boost-program_options
#opkg remove boost-system
#opkg remove brook
#opkg remove bsdtar
#opkg remove btrfs-progs
#opkg remove bzip2
#opkg remove ca-certificates
#opkg remove carl9170-firmware
#opkg remove chat
#opkg remove chinadns-ng
#opkg remove comgt
#opkg remove comgt-ncm
#opkg remove containerd
#opkg remove coreutils-nohup
#opkg remove coreutils-stdbuf
#opkg remove coreutils-timeout
#opkg remove corkscrew
#opkg remove cpulimit
#opkg remove dbus
#opkg remove ddns-scripts_cloudflare.com-v4
#opkg remove dnsforwarder
#opkg remove dnsproxy
#opkg remove docker
#opkg remove docker-compose
#opkg remove dockerd
#opkg remove ebtables
#opkg remove ebtables-utils
#opkg remove f2fs-tools
#opkg remove f2fsck
#opkg remove fdisk
#opkg remove fstrim
#opkg remove getdns
#opkg remove git
#opkg remove glib2
#opkg remove gpioctl-sysfs
#opkg remove gpiod-tools
#opkg remove gzip
#opkg remove haproxy
#opkg remove hd-idle
#opkg remove httping
#opkg remove https-dns-proxy
#opkg remove hysteria
#opkg remove i2c-tools
#opkg remove iconv
#opkg remove ip6tables
#opkg remove ip6tables-extra
#opkg remove ip6tables-mod-nat
#opkg remove iperf
#opkg remove ipt2socks
#opkg remove iptables-mod-conntrack-extra
#opkg remove iptables-mod-extra
#opkg remove iptables-mod-filter
#opkg remove iptables-mod-ipopt
#opkg remove iptables-mod-ipsec
#opkg remove iptables-mod-nat-extra
#opkg remove ipv6helper
#opkg remove irqbalance
#opkg remove jq
#opkg remove kcptun-client
#opkg remove kcptun-config

#
# Kernel Modules
#
#opkg remove kmod-ath
#opkg remove kmod-ath6kl
#opkg remove kmod-ath6kl-usb
#opkg remove kmod-ath9k-common
#opkg remove kmod-ath9k-htc
#opkg remove kmod-bonding
#opkg remove kmod-br-netfilter
#opkg remove kmod-carl9170
#opkg remove kmod-crypto-acompress
#opkg remove kmod-crypto-cbc
#opkg remove kmod-crypto-ccm
#opkg remove kmod-crypto-cmac
#opkg remove kmod-crypto-crc32
#opkg remove kmod-crypto-crc32c
#opkg remove kmod-crypto-ctr
#opkg remove kmod-crypto-cts
#opkg remove kmod-crypto-deflate
#opkg remove kmod-crypto-des
#opkg remove kmod-crypto-echainiv
#opkg remove kmod-crypto-gcm
#opkg remove kmod-crypto-gf128
#opkg remove kmod-crypto-ghash
#opkg remove kmod-crypto-hmac
#opkg remove kmod-crypto-kpp
#opkg remove kmod-crypto-lib-blake2s
#opkg remove kmod-crypto-lib-chacha20
#opkg remove kmod-crypto-lib-chacha20poly1305
#opkg remove kmod-crypto-lib-curve25519
#opkg remove kmod-crypto-lib-poly1305
#opkg remove kmod-crypto-md4
#opkg remove kmod-crypto-md5
#opkg remove kmod-crypto-rng
#opkg remove kmod-crypto-seqiv
#opkg remove kmod-crypto-sha256
#opkg remove kmod-crypto-sha512
#opkg remove kmod-dax
#opkg remove kmod-dm
#opkg remove kmod-dma-buf
#opkg remove kmod-dnsresolver
#opkg remove kmod-dummy
#opkg remove kmod-ebtables
#opkg remove kmod-eeprom-93cx6
#opkg remove kmod-fs-antfs
#opkg remove kmod-fs-btrfs
#opkg remove kmod-fs-cifs
#opkg remove kmod-fs-exfat
#opkg remove kmod-fs-exportfs
#opkg remove kmod-fs-ext4
#opkg remove kmod-fs-f2fs
#opkg remove kmod-fs-nfs
#opkg remove kmod-fs-nfs-common
#opkg remove kmod-fs-nfs-common-rpcsec
#opkg remove kmod-fs-nfs-v3
#opkg remove kmod-fs-nfs-v4
#opkg remove kmod-fs-nfsd
#opkg remove kmod-fs-squashfs
#opkg remove kmod-gre
#opkg remove kmod-hwmon-core
#opkg remove kmod-i2c-core
#opkg remove kmod-ifb
#opkg remove kmod-ikconfig
#opkg remove kmod-ip6tables-extra
#opkg remove kmod-ipsec
#opkg remove kmod-ipt-conntrack-extra
#opkg remove kmod-ipt-extra
#opkg remove kmod-ipt-filter
#opkg remove kmod-ipt-ipopt
#opkg remove kmod-ipt-ipsec
#opkg remove kmod-ipt-nat-extra
#opkg remove kmod-ipt-nat6
#opkg remove kmod-iptunnel
#opkg remove kmod-keys-encrypted
#opkg remove kmod-keys-trusted
#opkg remove kmod-l2tp
#opkg remove kmod-lib-crc-itu-t
#opkg remove kmod-lib-crc16
#opkg remove kmod-lib-crc32c
#opkg remove kmod-lib-lzo
#opkg remove kmod-lib-raid6
#opkg remove kmod-lib-xor
#opkg remove kmod-lib-zlib-deflate
#opkg remove kmod-lib-zlib-inflate
#opkg remove kmod-lib-zstd
#opkg remove kmod-lib80211
#opkg remove kmod-libertas-usb
#opkg remove kmod-libphy
#opkg remove kmod-mac80211
#opkg remove kmod-md-mod
#opkg remove kmod-md-raid0
#opkg remove kmod-md-raid1
#opkg remove kmod-md-raid10
#opkg remove kmod-md-raid456
#opkg remove kmod-mii
#opkg remove kmod-mt76-connac
#opkg remove kmod-mt76-core
#opkg remove kmod-mt76-usb
#opkg remove kmod-mt7601u
#opkg remove kmod-mt7603
#opkg remove kmod-mt7615-common
#opkg remove kmod-mt7663-usb-sdio
#opkg remove kmod-mt7663u
#opkg remove kmod-mt76x0-common
#opkg remove kmod-mt76x02-common
#opkg remove kmod-mt76x02-usb
#opkg remove kmod-mt76x0u
#opkg remove kmod-mt76x2-common
#opkg remove kmod-mt76x2u
#opkg remove kmod-net-prism54
#opkg remove kmod-net-rtl8192su
#opkg remove kmod-nf-ipvs
#opkg remove kmod-nf-nat6
#opkg remove kmod-p54-common
#opkg remove kmod-p54-usb
#opkg remove kmod-pppol2tp
#opkg remove kmod-pptp
#opkg remove kmod-random-core
#opkg remove kmod-rsi91x
#opkg remove kmod-rsi91x-usb
#opkg remove kmod-rt2500-usb
#opkg remove kmod-rt2800-lib
#opkg remove kmod-rt2800-usb
#opkg remove kmod-rt2x00-lib
#opkg remove kmod-rt2x00-usb
#opkg remove kmod-rt73-usb
#opkg remove kmod-rtl8187
#opkg remove kmod-rtl8188eu
#opkg remove kmod-rtl8192c-common
#opkg remove kmod-rtl8192cu
#opkg remove kmod-rtl8812au-ac
#opkg remove kmod-rtl8821cu
#opkg remove kmod-rtl88x2bu
#opkg remove kmod-rtlwifi
#opkg remove kmod-rtlwifi-usb
#opkg remove kmod-sched-core
#opkg remove kmod-scsi-core
#opkg remove kmod-tpm
#opkg remove kmod-tun
#opkg remove kmod-udptunnel4
#opkg remove kmod-udptunnel6
#opkg remove kmod-usb-acm
#opkg remove kmod-usb-audio
#opkg remove kmod-usb-ehci
#opkg remove kmod-usb-gadget
#opkg remove kmod-usb-net
#opkg remove kmod-usb-net-asix
#opkg remove kmod-usb-net-asix-ax88179
#opkg remove kmod-usb-net-cdc-eem
#opkg remove kmod-usb-net-cdc-ether
#opkg remove kmod-usb-net-cdc-mbim
#opkg remove kmod-usb-net-cdc-ncm
#opkg remove kmod-usb-net-cdc-subset
#opkg remove kmod-usb-net-dm9601-ether
#opkg remove kmod-usb-net-hso
#opkg remove kmod-usb-net-huawei-cdc-ncm
#opkg remove kmod-usb-net-ipheth
#opkg remove kmod-usb-net-kalmia
#opkg remove kmod-usb-net-kaweth
#opkg remove kmod-usb-net-mcs7830
#opkg remove kmod-usb-net-pegasus
#opkg remove kmod-usb-net-pl
#opkg remove kmod-usb-net-qmi-wwan
#opkg remove kmod-usb-net-rndis
#opkg remove kmod-usb-net-rtl8150
#opkg remove kmod-usb-net-rtl8152-vendor
#opkg remove kmod-usb-net-sierrawireless
#opkg remove kmod-usb-net-smsc95xx
#opkg remove kmod-usb-net-sr9700
#opkg remove kmod-usb-net2280
#opkg remove kmod-usb-ohci
#opkg remove kmod-usb-ohci-pci
#opkg remove kmod-usb-printer
#opkg remove kmod-usb-serial
#opkg remove kmod-usb-serial-option
#opkg remove kmod-usb-serial-qualcomm
#opkg remove kmod-usb-serial-wwan
#opkg remove kmod-usb-storage
#opkg remove kmod-usb-storage-extras
#opkg remove kmod-usb-storage-uas
#opkg remove kmod-usb-uhci
#opkg remove kmod-usb-wdm
#opkg remove kmod-usb-xhci-hcd
#opkg remove kmod-usb2
#opkg remove kmod-usb2-pci
#opkg remove kmod-usb3
#opkg remove kmod-veth
#opkg remove kmod-video-core
#opkg remove kmod-video-uvc
#opkg remove kmod-video-videobuf2
#opkg remove kmod-vxlan
#opkg remove kmod-wireguard
#opkg remove kmod-zd1211rw


#opkg remove libarchive
#opkg remove libatomic
#opkg remove libattr
#opkg remove libbz2
#opkg remove libcap
#opkg remove libcap-bin
#opkg remove libcharset
#opkg remove libdb47
#opkg remove libdbus
#opkg remove libdevmapper
#opkg remove libertas-usb-firmware
#opkg remove libevdev
#opkg remove libevent2
#opkg remove libevent2-core
#opkg remove libexpat
#opkg remove libfdisk
#opkg remove libffi
#opkg remove libgdbm
#opkg remove libgmp
#opkg remove libgnutls
#opkg remove libgpiod
#opkg remove libi2c
#opkg remove libiconv-full
#opkg remove libimobiledevice
#opkg remove libimobiledevice-utils
#opkg remove libltdl
#opkg remove liblua5.3
#opkg remove liblzma
#opkg remove liblzo
#opkg remove libmaxminddb
#opkg remove libmbim
#opkg remove libminiupnpc
#opkg remove libmount
#opkg remove libnatpmp
#opkg remove libnetsnmp
#opkg remove libnettle
#opkg remove libnetwork
#opkg remove libnghttp2
#opkg remove libnss
#opkg remove libpci
#opkg remove libpcre2
#opkg remove libplist
#opkg remove libpython3
#opkg remove libqmi
#opkg remove libqrtr-glib
#opkg remove libreadline
#opkg remove libruby
#opkg remove libseccomp
#opkg remove libsqlite3
#opkg remove libssh
#opkg remove libstdcpp
#opkg remove libtasn1
#opkg remove libudev-zero
#opkg remove libugpio
#opkg remove libusb-1.0
#opkg remove libusbmuxd
#opkg remove libusbmuxd-utils
#opkg remove libuv
#opkg remove libwebsockets-full
#opkg remove libxml2
#opkg remove libyaml
#opkg remove lsblk
#opkg remove lscpu
#opkg remove lua-maxminddb

#
# LuCI App / GUI
#
#opkg remove luci-app-3ginfo
#opkg remove luci-app-adbyby-plus
#opkg remove luci-app-adguardhome
#opkg remove luci-app-argon-config
#opkg remove luci-app-aria2
#opkg remove luci-app-atinout-mod
#opkg remove luci-app-bypass
#opkg remove luci-app-bypass_INCLUDE_Kcptun
#opkg remove luci-app-bypass_INCLUDE_NaiveProxy
#opkg remove luci-app-bypass_INCLUDE_Simple_obfs_server
#opkg remove luci-app-bypass_INCLUDE_V2ray_plugin
#opkg remove luci-app-cifs-mount
#opkg remove luci-app-commands
#opkg remove luci-app-cpulimit
#opkg remove luci-app-diskman
#opkg remove luci-app-diskman_INCLUDE_kmod_md_linear
#opkg remove luci-app-diskman_INCLUDE_kmod_md_raid456
#opkg remove luci-app-diskman_INCLUDE_mdadm
#opkg remove luci-app-dockerman
#opkg remove luci-app-eqos
#opkg remove luci-app-fileassistant
#opkg remove luci-app-filebrowser
#opkg remove luci-app-hd-idle
#opkg remove luci-app-libernet-plus
#opkg remove luci-app-mikhmon
#opkg remove luci-app-mmconfig
#opkg remove luci-app-modeminfo
#opkg remove luci-app-mwan3
#opkg remove luci-app-openclash
#opkg remove luci-app-openspeedtest
#opkg remove luci-app-openvpn
#opkg remove luci-app-passwall
#opkg remove luci-app-passwall_INCLUDE_Brook
#opkg remove luci-app-passwall_INCLUDE_Hysteria
#opkg remove luci-app-passwall_INCLUDE_Kcptun
#opkg remove luci-app-passwall_INCLUDE_NaiveProxy
#opkg remove luci-app-passwall_INCLUDE_ShadowsocksR_Libev_Server
#opkg remove luci-app-passwall_INCLUDE_Trojan_GO
#opkg remove luci-app-pptp-server
#opkg remove luci-app-qbittorrent
#opkg remove luci-app-samba
#opkg remove luci-app-shutdown
#opkg remove luci-app-sms-tool
#opkg remove luci-app-smstools3
#opkg remove luci-app-softethervpn
#opkg remove luci-app-ssr-plus_INCLUDE_Kcptun
#opkg remove luci-app-ssr-plus_INCLUDE_NaiveProxy
#opkg remove luci-app-ssr-plus_INCLUDE_Redsocks2
#opkg remove luci-app-ssr-plus_INCLUDE_Shadowsocks_Rust_Client
#opkg remove luci-app-ssr-plus_INCLUDE_Shadowsocks_Rust_Server
#opkg remove luci-app-ssr-plus_INCLUDE_Trojan
#opkg remove luci-app-ssr-plus_INCLUDE_V2ray_Plugin
#opkg remove luci-app-tinyfilemanager
#opkg remove luci-app-ttyd
#opkg remove luci-app-turboacc_INCLUDE_DNSFORWARDER
#opkg remove luci-app-turboacc_INCLUDE_DNSPROXY
#opkg remove luci-app-uhttpd
#opkg remove luci-app-usb-printer
#opkg remove luci-app-v2raya
#opkg remove luci-app-vpnbypass
#opkg remove luci-app-wireguard
#opkg remove luci-app-wrtbwmon
#opkg remove luci-app-xderm-bin
#opkg remove luci-app-xderm-limit
#opkg remove luci-app-zerotier

#
# LuCI Compat
#
#opkg remove luci-compat

#
# LuCI Languages
#
#opkg remove luci-i18n-3ginfo-en
#opkg remove luci-i18n-adbyby-plus-zh-cn
#opkg remove luci-i18n-adguardhome-zh-cn
#opkg remove luci-i18n-argon-config-zh-cn
#opkg remove luci-i18n-aria2-zh-cn
#opkg remove luci-i18n-base-en
#opkg remove luci-i18n-bonding-en
#opkg remove luci-i18n-bonding-zh-cn
#opkg remove luci-i18n-bypass-zh-cn
#opkg remove luci-i18n-cifs-mount-zh-cn
#opkg remove luci-i18n-commands-en
#opkg remove luci-i18n-commands-zh-cn
#opkg remove luci-i18n-cpulimit-zh-cn
#opkg remove luci-i18n-ddns-en
#opkg remove luci-i18n-dockerman-zh-cn
#opkg remove luci-i18n-eqos-zh-cn
#opkg remove luci-i18n-filebrowser-zh-cn
#opkg remove luci-i18n-firewall-en
#opkg remove luci-i18n-hd-idle-en
#opkg remove luci-i18n-hd-idle-zh-cn
#opkg remove luci-i18n-minieap-zh-cn
#opkg remove luci-i18n-mwan3-zh-cn
#opkg remove luci-i18n-openvpn-en
#opkg remove luci-i18n-openvpn-zh-cn
#opkg remove luci-i18n-passwall-zh-cn
#opkg remove luci-i18n-pptp-server-zh-cn
#opkg remove luci-i18n-qbittorrent-zh-cn
#opkg remove luci-i18n-samba-en
#opkg remove luci-i18n-samba-zh-cn
#opkg remove luci-i18n-softethervpn-zh-cn
#opkg remove luci-i18n-ttyd-zh-cn
#opkg remove luci-i18n-uhttpd-zh-cn
#opkg remove luci-i18n-upnp-en
#opkg remove luci-i18n-usb-printer-zh-cn
#opkg remove luci-i18n-vpnbypass-zh-cn
#opkg remove luci-i18n-wireguard-zh-cn
#opkg remove luci-i18n-wol-en
#opkg remove luci-i18n-wrtbwmon-zh-cn
#opkg remove luci-i18n-zerotier-zh-cn

#
# LuCI Lib Docker
#
#opkg remove luci-lib-docker

#
# LuCI Interface Protocol
#
#opkg remove luci-proto-3g
#opkg remove luci-proto-bonding
#opkg remove luci-proto-ipv6
#opkg remove luci-proto-minieap
#opkg remove luci-proto-modemmanager
#opkg remove luci-proto-ncm
#opkg remove luci-proto-openconnect
#opkg remove luci-proto-qmi
#opkg remove luci-proto-relay
#opkg remove luci-proto-wireguard

#
# LuCI Themes
#
#opkg remove luci-theme-argon
#opkg remove luci-theme-atmaterial_new
#opkg remove luci-theme-edge
#opkg remove luci-theme-ifit
#opkg remove luci-theme-material
#opkg remove luci-theme-netgear
#opkg remove luci-theme-opentomato
#opkg remove luci-theme-opentomcat
#opkg remove luci-theme-opentopd

#opkg remove luci-udptools
#opkg remove mdadm
#opkg remove minicom
#opkg remove minieap
#opkg remove modemmanager
#opkg remove msgpack-c
#opkg remove mt7601u-firmware
#opkg remove mwan3
#opkg remove naiveproxy
#opkg remove nano
#opkg remove node
#opkg remove node-npm
#opkg remove nspr
#opkg remove odhcp6c
#opkg remove odhcp6c_ext_cer_id=0
#opkg remove odhcpd-ipv6only
#opkg remove odhcpd_ipv6only_ext_cer_id=0
#opkg remove openconnect
#opkg remove openssh-client
#opkg remove openssh-sftp-client
#opkg remove openssh-sftp-server
#opkg remove openvpn-easy-rsa
#opkg remove openvpn-openssl
#opkg remove p54-usb-firmware
#opkg remove p910nd
#opkg remove parted
#opkg remove php7
#opkg remove php7-cgi
#opkg remove php7-mod-json
#opkg remove php7-mod-session
#opkg remove picocom
#opkg remove ppp-mod-pppol2tp
#opkg remove ppp-mod-pptp
#opkg remove pptpd
#opkg remove prism54-firmware
#opkg remove procps-ng
#opkg remove procps-ng-ps
#opkg remove proto-bonding

#
# Phyton packages
#
#opkg remove python-pip-conf
#opkg remove python3
#opkg remove python3-asyncio
#opkg remove python3-attrs
#opkg remove python3-base
#opkg remove python3-bcrypt
#opkg remove python3-cached-property
#opkg remove python3-certifi
#opkg remove python3-cffi
#opkg remove python3-cgi
#opkg remove python3-cgitb
#opkg remove python3-chardet
#opkg remove python3-codecs
#opkg remove python3-cryptography
#opkg remove python3-ctypes
#opkg remove python3-dbm
#opkg remove python3-decimal
#opkg remove python3-distro
#opkg remove python3-distutils
#opkg remove python3-docker
#opkg remove python3-dockerpty
#opkg remove python3-docopt
#opkg remove python3-dotenv
#opkg remove python3-email
#opkg remove python3-gdbm
#opkg remove python3-idna
#opkg remove python3-jsonschema
#opkg remove python3-light
#opkg remove python3-logging
#opkg remove python3-lzma
#opkg remove python3-multiprocessing
#opkg remove python3-ncurses
#opkg remove python3-openssl
#opkg remove python3-paramiko
#opkg remove python3-pip
#opkg remove python3-pkg-resources
#opkg remove python3-ply
#opkg remove python3-pycparser
#opkg remove python3-pydoc
#opkg remove python3-pynacl
#opkg remove python3-pyrsistent
#opkg remove python3-readline
#opkg remove python3-requests
#opkg remove python3-setuptools
#opkg remove python3-six
#opkg remove python3-sqlite3
#opkg remove python3-texttable
#opkg remove python3-unittest
#opkg remove python3-urllib
#opkg remove python3-urllib3
#opkg remove python3-websocket-client
#opkg remove python3-xml
#opkg remove python3-yaml


#opkg remove qBittorrent-static
#opkg remove qmi-utils
#opkg remove redsocks2
#opkg remove relayd
#opkg remove resize2fs


#opkg remove rs9113-firmware
#opkg remove rt2800-usb-firmware
#opkg remove rt73-usb-firmware
#opkg remove rtl8188eu-firmware
#opkg remove rtl8192cu-firmware
#opkg remove rtl8192eu-firmware
#opkg remove rtl8192su-firmware
#opkg remove rtl8723au-firmware
#opkg remove rtl8723bu-firmware


#opkg remove ruby
#opkg remove ruby-bigdecimal
#opkg remove ruby-date
#opkg remove ruby-dbm
#opkg remove ruby-digest
#opkg remove ruby-enc
#opkg remove ruby-forwardable
#opkg remove ruby-pstore
#opkg remove ruby-psych
#opkg remove ruby-stringio
#opkg remove ruby-strscan
#opkg remove ruby-yaml


#opkg remove runc
#opkg remove samba36-server
#opkg remove screen
#opkg remove shadowsocks-rust-sslocal
#opkg remove shadowsocks-rust-ssserver
#opkg remove simple-obfs-server
#opkg remove smartdns-le
#opkg remove smartmontools
#opkg remove sms-tool
#opkg remove smstools3
#opkg remove snmpd


#opkg remove softethervpn5-bridge
#opkg remove softethervpn5-client
#opkg remove softethervpn5-libs
#opkg remove softethervpn5-server


#opkg remove sshpass
#opkg remove stubby
#opkg remove stunnel
#opkg remove tc-mod-iptables
#opkg remove tc-tiny
#opkg remove tini
#opkg remove tmate
#opkg remove tmux
#opkg remove tree

#opkg remove trojan
#opkg remove trojan-go
#opkg remove trojan-plus

#opkg remove ttyd
#opkg remove udp2raw-tunnel
#opkg remove umbim
#opkg remove unzip
#opkg remove uqmi
#opkg remove usb-modeswitch
#opkg remove usbids
#opkg remove usbmuxd
#opkg remove usbutils
#opkg remove v2ray-core
#opkg remove v2ray-plugin
#opkg remove v2raya
#opkg remove vim-full
#opkg remove vpnbypass
#opkg remove vpnc-scripts
#opkg remove webui-aria2
#opkg remove whereis
#opkg remove wireguard-tools
#opkg remove wrtbwmon
#opkg remove wwan
#opkg remove xl2tpd
#opkg remove xray-plugin
#opkg remove zerotier
#opkg remove zoneinfo-core

#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# Fix issue --Global symbol "@mrirors" requires explicit package name (did you forget to declare "my @mrirors"?) at tools/xz failed to build.
sed -i 's/mrirors/mirrors/g' $OPENWRT_ROOT_PATH/scripts/download.pl

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Mod default-settings
[ -d package/emortal/default-settings/files ] && pushd package/emortal/default-settings/files
sed -i 's#exit 0#chmod +x /etc/init.d/zzzwrtmi\n/etc/init.d/zzzwrtmi enable#g' 99-default-settings
cat << 'EOF' >>  99-default-settings
if ! grep '/usr/bin/zsh' /etc/passwd
sed -i 's|/bin/ash|/usr/bin/zsh|g' /etc/passwd
fi

exit 0
EOF
echo "=== helmilog: Below is 99-default-settings contents.. ==="
cat 99-default-settings
echo "=== helmilog: Below is 99-default-settings contents.. ==="
popd

pushd package/base-files
sed -i 's/ImmortalWrt/HelmiWrt/g' image-config.in
sed -i 's/ImmortalWrt/HelmiWrt/g' files/bin/config_generate
sed -i 's/UTC/WIB-7/g' files/bin/config_generate
popd

sed -i 's/ImmortalWrt/HelmiWrt/g' config/Config-images.in
sed -i 's/ImmortalWrt/HelmiWrt/g' include/version.mk
sed -i 's/immortalwrt.org/helmiau.com/g' include/version.mk
sed -i 's|github.com/immortalwrt/immortalwrt/issues|helmiau.com|g' include/version.mk
sed -i 's|github.com/immortalwrt/immortalwrt/discussions|helmiau.com|g' include/version.mk

# Delete ImmortalWrt source
find . -type d -name "luci-app-openclash" -exec rm -rf "{}" \;
find . -type f -name "luci-app-openclash" -exec rm -rf "{}" \;

# Add date version
export DATE_VERSION=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add Argon theme configuration
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config

# Add official OpenClash dev branch source
# git clone --depth=1 -b dev https://github.com/vernesong/OpenClash
svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash vernesong/OpenClash

# Add modeminfo
svn co https://github.com/koshev-msk/modemfeed/trunk/luci/applications/luci-app-modeminfo koshev-msk/luci-app-modeminfo
svn co https://github.com/koshev-msk/modemfeed/trunk/packages/net/modeminfo koshev-msk/modeminfo
# Remove modeminfo telegrambot plugin
[[ -f koshev-msk/modeminfo/Makefile ]] && sed -i -e '/Package\/\$(PKG_NAME)-telegram\/install/,+4d' -e '/Package\/\$(PKG_NAME)-telegram/,+6d' -e '/\$(eval \$(call BuildPackage,\$(PKG_NAME)-telegram))/,+0d' koshev-msk/modeminfo/Makefile
[[ -f koshev-msk/modeminfo/root/usr/lib/telegrambot/plugins/modeminfo.sh ]] && rm -f koshev-msk/modeminfo/root/usr/lib/telegrambot/plugins/modeminfo.sh

# Add luci-app-smstools3
svn co https://github.com/koshev-msk/modemfeed/trunk/luci/applications/luci-app-smstools3 koshev-msk/luci-app-smstools3

# Add luci-app-mmconfig : configure modem cellular bands via mmcli utility
svn co https://github.com/koshev-msk/modemfeed/trunk/luci/applications/luci-app-mmconfig koshev-msk/luci-app-mmconfig

# Add support for Fibocom L860-GL l850/l860 ncm
svn co https://github.com/koshev-msk/modemfeed/trunk/packages/net/xmm-modem koshev-msk/xmm-modem

if [[ $SOURCE_BRANCH != *"18.06"* ]]; then
	echo "21.02 or 23.05 branch detected! Adding 21.02 repos..."
	# Add luci-app-modemband
	echo "Adding luci-app-modemband..."
	git clone --depth=1 https://github.com/4IceG/luci-app-modemband
	# Add 3ginfo, luci-app-3ginfo-lite
	echo "Adding luci-app-3ginfo-lite..."
	git clone --depth=1 https://github.com/4IceG/luci-app-3ginfo-lite
else
	echo "18.06 branch detected! Adding 18.06 repos..."
	# Add 3ginfo, luci-app-3ginfo
	echo "Adding luci-app-3ginfo..."
	git clone --depth=1 https://github.com/4IceG/luci-app-3ginfo
	sed -i 's/luci-app-3ginfo-lite/luci-app-3ginfo/g' $OPENWRT_ROOT_PATH/.config
fi

# Add luci-app-sms-tool
git clone --depth=1 https://github.com/4IceG/luci-app-sms-tool

# Add luci-app-atinout
svn co https://github.com/koshev-msk/modemfeed/trunk/luci/applications/luci-app-atinout koshev-msk/luci-app-atinout
svn co https://github.com/koshev-msk/modemfeed/trunk/packages/telephony/atinout koshev-msk/atinout

# Add qtools (Tools modems based on the Qualcomm chipset)
svn co https://github.com/koshev-msk/modemfeed/trunk/packages/telephony/qtools koshev-msk/qtools

# HelmiWrt packages
git clone --depth=1 https://github.com/helmiau/helmiwrt-packages
rm -rf helmiwrt-packages/luci-app-v2raya
# telegrambot
#svn co https://github.com/helmiau/helmiwrt-adds/trunk/packages/net/telegrambot helmiwrt-adds/telegrambot
#svn co https://github.com/helmiau/helmiwrt-adds/trunk/luci/luci-app-telegrambot helmiwrt-adds/luci-app-telegrambot

# Add LuCI v2rayA
#if [[ $SOURCE_BRANCH == *"18.06"* ]]; then
#	echo "OpenWrt $SOURCE_BRANCH detected! using luci-app-v2raya 18.06 branch..."
#	git clone --depth=1 -b 18.06 https://github.com/zxlhhyccc/luci-app-v2raya
#else 
#	echo "OpenWrt $SOURCE_BRANCH detected! using luci-app-v2raya master branch..."
#	git clone --depth=1 -b master https://github.com/zxlhhyccc/luci-app-v2raya
#fi

# Add luci-theme-neobird theme
git clone --depth=1 https://github.com/helmiau/luci-theme-neobird

if [[ $TOOLCHAIN_IMAGE == *"x86"* ]]; then
	echo "x86 target detected! Adding patches..."
	# Add rtl8723bu (tismart ds686) for x86
	svn co https://github.com/radityabh/raditya-package/branches/Kernel_5.4/rtl8723bu kernel/rtl8723bu
	echo -e "CONFIG_PACKAGE_kmod-rtl8723bu=y" >> $OPENWRT_ROOT_PATH/.config
	# Fix USB to LAN
	# sed -i 's/kmod-usb-net-rtl8152=/kmod-usb-net-rtl8152-vendor=/g' $OPENWRT_ROOT_PATH/.config
	# Add Configs to Kernel Config
	[ -f $OPENWRT_ROOT_PATH/target/linux/x86/config-5.4 ] && cat $GITHUB_WORKSPACE/config/x86-kernel.config >> $OPENWRT_ROOT_PATH/target/linux/x86/config-5.4
	[ -f $OPENWRT_ROOT_PATH/target/linux/x86/generic/config-5.4 ] && cat $GITHUB_WORKSPACE/config/x86-kernel.config >> $OPENWRT_ROOT_PATH/target/linux/x86/generic/config-5.4
	[ -f $OPENWRT_ROOT_PATH/target/linux/x86/64/config-5.4 ] && cat $GITHUB_WORKSPACE/config/x86-kernel.config >> $OPENWRT_ROOT_PATH/target/linux/x86/64/config-5.4
fi

if [[ $TOOLCHAIN_IMAGE == *"armvirt"* ]]; then
	# Add luci-app-amlogic
	echo "armvirt target detected! Adding amlogic service..."
	git clone --depth=1 https://github.com/helmiau/luci-app-amlogic
	cat << 'EOF' >> $OPENWRT_ROOT_PATH/.config
# Packages for Amlogic Service
CONFIG_PACKAGE_dosfstools=y
CONFIG_PACKAGE_util-linux=y
CONFIG_PACKAGE_uuidgen=y
CONFIG_PACKAGE_luci-lib-fs=y
CONFIG_PACKAGE_perl=y
CONFIG_PERL_NOCOMMENT=y
CONFIG_PACKAGE_perl-http-date=y
CONFIG_PACKAGE_perlbase-base=y
CONFIG_PACKAGE_perlbase-bytes=y
CONFIG_PACKAGE_perlbase-charnames=y
CONFIG_PACKAGE_perlbase-class=y
CONFIG_PACKAGE_perlbase-config=y
CONFIG_PACKAGE_perlbase-cwd=y
CONFIG_PACKAGE_perlbase-dynaloader=y
CONFIG_PACKAGE_perlbase-errno=y
CONFIG_PACKAGE_perlbase-essential=y
CONFIG_PACKAGE_perlbase-fcntl=y
CONFIG_PACKAGE_perlbase-file=y
CONFIG_PACKAGE_perlbase-filehandle=y
CONFIG_PACKAGE_perlbase-getopt=y
CONFIG_PACKAGE_perlbase-i18n=y
CONFIG_PACKAGE_perlbase-integer=y
CONFIG_PACKAGE_perlbase-io=y
CONFIG_PACKAGE_perlbase-list=y
CONFIG_PACKAGE_perlbase-locale=y
CONFIG_PACKAGE_perlbase-params=y
CONFIG_PACKAGE_perlbase-posix=y
CONFIG_PACKAGE_perlbase-re=y
CONFIG_PACKAGE_perlbase-scalar=y
CONFIG_PACKAGE_perlbase-selectsaver=y
CONFIG_PACKAGE_perlbase-socket=y
CONFIG_PACKAGE_perlbase-symbol=y
CONFIG_PACKAGE_perlbase-tie=y
CONFIG_PACKAGE_perlbase-time=y
CONFIG_PACKAGE_perlbase-unicode=y
CONFIG_PACKAGE_perlbase-unicore=y
CONFIG_PACKAGE_perlbase-utf8=y
CONFIG_PACKAGE_perlbase-xsloader=y
EOF
	# Fix USB to LAN
	# sed -i 's/kmod-usb-net-rtl8152=/kmod-usb-net-rtl8152-vendor=/g' $OPENWRT_ROOT_PATH/.config
fi

if [[ $TOOLCHAIN_IMAGE == *"rockchip-armv8"* ]]; then
	# Add rockchip-armv8 patches
	echo "rockchip-armv8 target detected! Adding patches..."
	sed -i "s|Shadowsocks_Libev_Client=y|Shadowsocks_Libev_Client=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|Shadowsocks_Libev_Server=y|Shadowsocks_Libev_Server=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|Shadowsocks_Rust_Client=n|Shadowsocks_Rust_Client=y|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|Shadowsocks_Rust_Client=n|Shadowsocks_Rust_Client=y|g" $OPENWRT_ROOT_PATH/.config
fi

if [[ $TOOLCHAIN_IMAGE == *"sunxi-cortexa53"* ]]; then
	# Add sunxi cortexa53
	echo "sunxi cortexa53 target detected! Adding patches..."
	sed -i "s|hostapd-utils=y|hostapd-utils=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|hostapd-common=y|hostapd-common=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|hostapd=y|hostapd=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|wpa-supplicant=y|wpa-supplicant=n|g" $OPENWRT_ROOT_PATH/.config
fi

if [[ $TOOLCHAIN_IMAGE == *"sunxi-cortexa7"* ]]; then
	# Add sunxi cortexa7
	echo "sunxi cortexa7 target detected! Adding patches..."
	sed -i "s|hostapd-utils=y|hostapd-utils=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|hostapd-common=y|hostapd-common=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|hostapd=y|hostapd=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|wpa-supplicant=y|wpa-supplicant=n|g" $OPENWRT_ROOT_PATH/.config
fi

if [[ $TOOLCHAIN_IMAGE == *"bcm2711"* ]]; then
	# Add bcm2711 patches
	echo "bcm2711 target detected! Adding patches..."
	echo -e "CONFIG_USB_LAN78XX=y\nCONFIG_USB_NET_DRIVERS=y" >> $OPENWRT_ROOT_PATH/target/linux/bcm27xx/bcm2711/config-5.4
	sed -i 's/36/44/g;s/VHT80/VHT20/g' $OPENWRT_ROOT_PATH/package/kernel/mac80211/files/lib/wifi/mac80211.sh
else
	# Add non-bcm2711 patches
	echo "non-bcm2711 target detected! Adding patches..."
	pinctrl_bcm2835_dir=$OPENWRT_ROOT_PATH/target/linux/bcm27xx/patches-5.4/950-0316-pinctrl-bcm2835-Add-support-for-BCM2711-pull-up-func.patch
	[ -f $pinctrl_bcm2835_dir ] && rm -f $pinctrl_bcm2835_dir
fi

if [[ $TOOLCHAIN_IMAGE == *"bcm27xx"* ]]; then
	# Fix USB to LAN for bcm27xx devices
	echo "non-bcm2711 target detected! Adding patches..."
	sed -i 's/kmod-usb-net-rtl8152=/kmod-usb-net-rtl8152-vendor=/g' $OPENWRT_ROOT_PATH/.config
fi

if [[ $SOURCE_BRANCH != *"18.06"* ]]; then
	echo "OpenWrt $SOURCE_BRANCH detected! adding openwrt-$SOURCE_BRANCH config..."
	sed -i "s|argonv3=y|argon=y|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|edge=y|edge=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|neobird=y|neobird=n|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|vnstat=y|vnstat2=y|g" $OPENWRT_ROOT_PATH/.config
	sed -i "s|vnstati=y|vnstati2=y|g" $OPENWRT_ROOT_PATH/.config
	# Add Docker LuCI
	echo -e "CONFIG_PACKAGE_luci-app-docker=y" >> $OPENWRT_ROOT_PATH/.config
fi

# Add Adguardhome
git clone --depth=1 https://github.com/yang229/luci-app-adguardhome

# Add CUPS (Common UNIX Printing System) - https://www.cups.org/ & https://openprinting.github.io/cups/
# Source https://techlife.nz/blog/howto-getting-cups-working-on-openwrt-guide/
# Tutorial https://github.com/TheMMcOfficial/cups-for-openwrt
# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-cupsd kiddin9/luci-app-cupsd

popd

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Rename hostname to HelmiWrt
pushd package/base-files/files/bin
sed -i 's/ImmortalWrt/HelmiWrt/g' config_generate
popd

# Change default shell to zsh
sed -i 's|/bin/ash|/usr/bin/zsh|g' package/base-files/files/etc/passwd

#-----------------------------------------------------------------------------
#   Start of @helmiau terminal scripts additionals menu
#-----------------------------------------------------------------------------
HWOSDIR="package/base-files/files"
rawgit="https://raw.githubusercontent.com"
# Make dir if not exist
[ ! -d $HWOSDIR/bin ] && mkdir -p $HWOSDIR/bin
[ ! -d $HWOSDIR/etc/init.d ] && mkdir -p $HWOSDIR/etc/init.d
[ ! -d $HWOSDIR/root ] && mkdir -p $HWOSDIR/root
[ ! -d $HWOSDIR/usr/bin ] && mkdir -p $HWOSDIR/usr/bin

# Add vmess creator account from racevpn.com
# run "vmess" using terminal to create free vmess account
# wget -qO $HWOSDIR/bin/vmess "$rawgit/ryanfauzi1/vmesscreator/main/vmess"

# Add ocmetawss: "OpenClash Websocket Mod Core" script downloader
# run "ocmetawss" using terminal to check ram usage
wget --no-check-certificate -qO $HWOSDIR/bin/ocmetawss "$rawgit/helmiau/openwrt-config/main/others/ocmetawss"

# Add ocmetawss: "OpenClash Websocket Mod Core" script downloader
# run "ocmetawss" using terminal to check ram usage
wget --no-check-certificate -qO $HWOSDIR/usr/bin/jam.sh "$rawgit/helmiau/sync-date-openwrt-with-bug/main/jam.sh"

# Add fix download file.php for xderm and libernet
# run "fixphp" using terminal for use
wget --no-check-certificate -qO $HWOSDIR/bin/fixphp "$rawgit/helmiau/openwrt-config/main/fix-xderm-libernet-gui"

# Add PHPTeleWrtBot - https://www.helmiau.com/blog/phptelebotwrt
# run "./phpbotmgr e" using terminal TO EDIT TELEGRAM BOT TOKEN, BOT ID AND USER ID
wget --no-check-certificate -qO $HWOSDIR/root/phpbotmgr "$rawgit/helmiau/PHPTeleBotWrt/master/phpbotmgr"
[ ! -d $HWOSDIR/root/PHPTeleBotWrt ] && mkdir -p $HWOSDIR/root/PHPTeleBotWrt
git clone --depth=1 https://github.com/helmiau/PHPTeleBotWrt $HWOSDIR/root/PHPTeleBotWrt

# Add wegare123 stl tools
# run "stl" using terminal for use
wgr="wegare123"
[ ! -d $HWOSDIR/root/akun ] && mkdir -p $HWOSDIR/root/akun
wget --no-check-certificate -qO $HWOSDIR/usr/bin/stl "$rawgit/$wgr/stl/main/stl/stl.sh"
wget --no-check-certificate -qO $HWOSDIR/usr/bin/gproxy "$rawgit/$wgr/stl/main/stl/gproxy.sh"
wget --no-check-certificate -qO $HWOSDIR/usr/bin/autorekonek-stl "$rawgit/$wgr/stl/main/stl/autorekonek-stl.sh"
wget --no-check-certificate -qO $HWOSDIR/root/akun/tunnel.py "$rawgit/$wgr/stl/main/stl/tunnel.py"
wget --no-check-certificate -qO $HWOSDIR/root/akun/ssh.py "$rawgit/$wgr/stl/main/stl/ssh.py"
wget --no-check-certificate -qO $HWOSDIR/root/akun/inject.py "$rawgit/$wgr/stl/main/stl/inject.py"

# Add ram checker from wegare123
# run "ram" using terminal to check ram usage
wget --no-check-certificate -qO $HWOSDIR/bin/ram "$rawgit/$wgr/ram/main/ram.sh"


# Add wifi id seamless autologin by kopijahe
# run "kopijahe" using terminal for use
wget --no-check-certificate -qO $HWOSDIR/bin/kopijahe "$rawgit/kopijahe/wifiid-openwrt/master/scripts/kopijahe"

chmod 0755 -R $HWOSDIR/bin/*
chmod 0755 -R $HWOSDIR/etc/init.d/*
chmod 0755 -R $HWOSDIR/root/*
chmod 0755 -R $HWOSDIR/usr/bin/*

#-----------------------------------------------------------------------------
#   End of @helmiau terminal scripts additionals menu
#-----------------------------------------------------------------------------

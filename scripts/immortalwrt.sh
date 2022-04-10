#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Mod zzz-default-settings
pushd package/emortal/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/openwrt_luci/d' zzz-default-settings
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

# Add date version
export DATE_VERSION=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add modeminfo
git clone --depth=1 https://github.com/koshev-msk/luci-app-modeminfo

# Add luci-app-smstools3
git clone --depth=1 https://github.com/koshev-msk/luci-app-smstools3

# Add luci-app-mmconfig : configure modem cellular bands via mmcli utility
git clone --depth=1 https://github.com/koshev-msk/luci-app-mmconfig

# Add support for Fibocom L860-GL l850/l860 ncm
git clone --depth=1 https://github.com/koshev-msk/xmm-modem

# Add 3ginfo, luci-app-3ginfo
git clone --depth=1 https://github.com/4IceG/luci-app-3ginfo

# Add luci-app-sms-tool
git clone --depth=1 https://github.com/4IceG/luci-app-sms-tool

# Add luci-app-atinout-mod
git clone --depth=1 https://github.com/4IceG/luci-app-atinout-mod

# Add luci-app-mqos
git clone --depth=1 https://github.com/WROIATE/luci-app-mqos

# HelmiWrt packages
git clone --depth=1 https://github.com/helmiau/helmiwrt-packages
rm -rf helmiwrt-packages/luci-app-v2raya
# telegrambot
svn co https://github.com/helmiau/helmiwrt-adds/trunk/packages/net/telegrambot helmiwrt-adds/telegrambot
svn co https://github.com/helmiau/helmiwrt-adds/trunk/luci/luci-app-telegrambot helmiwrt-adds/luci-app-telegrambot

# Add LuCI v2rayA
git clone --depth=1 https://github.com/zxlhhyccc/luci-app-v2raya

# Add luci-theme-neobird theme
git clone --depth=1 https://github.com/helmiau/luci-theme-neobird

# Add themes from kenzok8 openwrt-packages
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new kenzok8/luci-theme-atmaterial_new
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge kenzok8/luci-theme-edge

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
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

#-----------------------------------------------------------------------------
#   Start of @helmiau terminal scripts additionals menu
#-----------------------------------------------------------------------------
HWOSDIR="package/base-files/files"
rawgit="https://raw.githubusercontent.com"

# Add vmess creator account from racevpn.com
# run "vmess" using terminal to create free vmess account
# wget -qO $HWOSDIR/bin/vmess "$rawgit/ryanfauzi1/vmesscreator/main/vmess"

# Add ram checker from wegare123
# run "ram" using terminal to check ram usage
wget -qO $HWOSDIR/bin/ram "$rawgit/wegare123/ram/main/ram.sh"

# Add fix download file.php for xderm and libernet
# run "fixphp" using terminal for use
wget -qO $HWOSDIR/bin/fixphp "$rawgit/helmiau/openwrt-config/main/fix-xderm-libernet-gui"

# Add wegare123 stl tools
# run "stl" using terminal for use
usergit="wegare123"
mkdir -p $HWOSDIR/root/akun $HWOSDIR/usr/bin
wget -qO $HWOSDIR/usr/bin/stl "$rawgit/$usergit/stl/main/stl/stl.sh"
wget -qO $HWOSDIR/usr/bin/gproxy "$rawgit/$usergit/stl/main/stl/gproxy.sh"
wget -qO $HWOSDIR/usr/bin/autorekonek-stl "$rawgit/$usergit/stl/main/stl/autorekonek-stl.sh"
wget -qO $HWOSDIR/root/akun/tunnel.py "$rawgit/$usergit/stl/main/stl/tunnel.py"
wget -qO $HWOSDIR/root/akun/ssh.py "$rawgit/$usergit/stl/main/stl/ssh.py"
wget -qO $HWOSDIR/root/akun/inject.py "$rawgit/$usergit/stl/main/stl/inject.py"

# Add wifi id seamless autologin by kopijahe
# run "kopijahe" using terminal for use
wget -qO $HWOSDIR/bin/kopijahe "$rawgit/kopijahe/wifiid-openwrt/master/scripts/kopijahe"

#-----------------------------------------------------------------------------
#   End of @helmiau terminal scripts additionals menu
#-----------------------------------------------------------------------------

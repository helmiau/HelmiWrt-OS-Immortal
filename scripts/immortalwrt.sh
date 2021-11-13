#!/bin/bash
#=================================================
# Description: DIY script for ImmortalWrt Repack
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

HWOSDIR="package/base-files/files"

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' $HWOSDIR/bin/config_generate

# Mod zzz-default-settings for HelmiWrt
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/openwrt_luci/d' zzz-default-settings
sed -i 's/zh_cn/auto/g' zzz-default-settings
sed -i 's/uci set fstab/uci set system.@system[0].hostname=HelmiWrt\nuci set system.@system[0].timezone=WIB-7\nuci commit system\n\nuci set fstab/g' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd

# Rename hostname to HelmiWrt
pushd package/base-files/files/bin
sed -i 's/ImmortalWrt/HelmiWrt/g' config_generate
popd

# Fix SDK
sed -i '/$(SDK_BUILD_DIR)\/$(STAGING_SUBDIR_HOST)\/usr\/bin/d' target/sdk/Makefile

# Fix Toolchain
sed -i 's/LICENSE/LICENSES/g' target/toolchain/Makefile

# Replace luci-app-aria2
pushd feeds/luci/applications
rm -rf luci-app-aria2
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aria2
popd

# Remove original luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall

# Remove original luci-app-dockerman and luci-lib-docker
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/luci/libs/luci-lib-docker

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Replace luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
sed -i 's/ upx\/host//g' openwrt-passwall/v2ray-plugin/Makefile
grep -lr upx/host openwrt-passwall/* | xargs -t -I {} sed -i '/upx\/host/d' {}

# Replace luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker

#-----------------------------------------------------------------------------
#   Start of @helmiau additionals packages for cloning repo 
#-----------------------------------------------------------------------------

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

# HelmiWrt packages
git clone --depth=1 https://github.com/helmiau/helmiwrt-packages

# Add themes from kenzok8 openwrt-packages
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge kenzok8/luci-theme-edge
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-opentopd kenzok8/luci-theme-opentopd

# Add Xradio kernel for Orange Pi Zero
svn co https://github.com/melsem/openwrt-lede_xradio-xr819_soc-audio/trunk/xradio-Openwrt_kernel-5.4.xx melsem/xradio

#-----------------------------------------------------------------------------
#   End of @helmiau additionals packages for cloning repo 
#-----------------------------------------------------------------------------
popd

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' $HWOSDIR/etc/passwd

#-----------------------------------------------------------------------------
#   Start of @helmiau terminal scripts additionals menu
#-----------------------------------------------------------------------------

# Add vmess creator account from racevpn.com
# run "vmess" using terminal to create free vmess account
wget -O $HWOSDIR/bin/vmess "https://raw.githubusercontent.com/ryanfauzi1/vmesscreator/main/vmess" && chmod +x $HWOSDIR/bin/vmess

# Add ram checker from wegare123
# run "ram" using terminal to check ram usage
wget -O $HWOSDIR/bin/ram "https://raw.githubusercontent.com/wegare123/ram/main/ram.sh" && chmod +x $HWOSDIR/bin/ram

# Add fix download file.php for xderm and libernet
# run "fixphp" using terminal for use
wget -O $HWOSDIR/bin/fixphp "https://raw.githubusercontent.com/helmiau/openwrt-config/main/fix-xderm-libernet-gui" && chmod +x $HWOSDIR/bin/fixphp

#-----------------------------------------------------------------------------
#   End of @helmiau terminal scripts additionals menu
#-----------------------------------------------------------------------------

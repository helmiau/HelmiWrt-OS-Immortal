#!/bin/bash
#=================================================
# File name: hook-feeds.sh
# Author: Helmi Amirudin
# Blog: https://helmiau.com
#=================================================
#--------------------------------------------------------
#   If you use some codes frome here, please give credit to www.helmiau.com
#--------------------------------------------------------

# Clone ImmortalWrt's feeds
mkdir customfeeds
pushd customfeeds
git clone --depth=1 https://github.com/immortalwrt/packages -b openwrt-18.06 packages
git clone --depth=1 https://github.com/immortalwrt/luci -b openwrt-18.06-k5.4 luci

# Add v2rayA
sed -i 's#include ../../lang/golang#include $(TOPDIR)/feeds/packages/lang/golang#g' packages/net/v2raya/Makefile

popd

# Update feeds
./scripts/feeds update -a
./scripts/feeds install -a

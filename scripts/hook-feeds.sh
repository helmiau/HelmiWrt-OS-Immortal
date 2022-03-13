#!/bin/bash
#=================================================
# File name: hook-feeds.sh
# Author: Helmi Amirudin
# Blog: https://helmiau.com
#=================================================
#--------------------------------------------------------
#   If you use some codes frome here, please give credit to www.helmiau.com
#--------------------------------------------------------

# List installed feeds
pushd feeds
echo "========================================"
echo "============   luci.index   ============"
#cat < luci.index
ls
echo "============ packages.index ============"
#cat < packages.index
echo "========================================"
popd

# Remove LuCI Apps
pushd feeds/luci/applications

ls | grep "openclash"

# Remove luci-app-ssr-plus
[ -d luci-app-ssr-plus ] && rm -rf luci-app-ssr-plus && echo "luci-app-ssr-plus deleted"

# Remove OpenClash
[ -d luci-app-openclash ] && rm -rf luci-app-openclash && echo "luci-app-openclash deleted"

# Remove Docker
[ -d luci-app-docker ] && rm -rf luci-app-docker && echo "luci-app-docker deleted"
[ -d luci-app-dockerman ] && rm -rf luci-app-dockerman && echo "luci-app-dockerman deleted"

# Remove Argon theme config
[ -d luci-app-argon-config ] && rm -rf luci-app-argon-config && echo "luci-app-argon-config deleted"

popd

# Remove LuCI Themes
pushd feeds/luci/themes

ls | grep "argon"

[ -d luci-theme-Butterfly-dark ] && rm -rf luci-theme-Butterfly-dark && echo "luci-theme-Butterfly-dark deleted"
[ -d luci-theme-Butterfly ] && rm -rf luci-theme-Butterfly && echo "luci-theme-Butterfly deleted"
[ -d luci-theme-argon ] && rm -rf luci-theme-argon && echo "luci-theme-argon deleted"
[ -d luci-theme-argonv2 ] && rm -rf luci-theme-argonv2 && echo "luci-theme-argonv2 deleted"
[ -d luci-theme-argonv3 ] && rm -rf luci-theme-argonv3 && echo "luci-theme-argonv3 deleted"
[ -d luci-theme-argon-dark-mod ] && rm -rf luci-theme-argon-dark-mod && echo "luci-theme-argon-dark-mod deleted"
[ -d luci-theme-argon-light-mod ] && rm -rf luci-theme-argon-light-mod && echo "luci-theme-argon-light-mod deleted"
[ -d luci-theme-argon-mc ] && rm -rf luci-theme-argon-mc && echo "luci-theme-argon-mc deleted"
[ -d luci-theme-argon-mod ] && rm -rf luci-theme-argon-mod && echo "luci-theme-argon-mod deleted"
[ -d luci-theme-atmaterial ] && rm -rf luci-theme-atmaterial && echo "luci-theme-atmaterial deleted"
[ -d luci-theme-bootstrap-mod ] && rm -rf luci-theme-bootstrap-mod && echo "luci-theme-bootstrap-mod deleted"
[ -d luci-theme-infinityfreedom ] && rm -rf luci-theme-infinityfreedom && echo "luci-theme-infinityfreedom deleted"
[ -d luci-theme-netgearv2 ] && rm -rf luci-theme-netgearv2 && echo "luci-theme-netgearv2 deleted"
[ -d luci-theme-argon ] && rm -rf luci-theme-argon && echo "luci-theme-argon deleted"
[ -d luci-theme-argon ] && rm -rf luci-theme-argon && echo "luci-theme-argon deleted"
[ -d luci-theme-argon ] && rm -rf luci-theme-argon && echo "luci-theme-argon deleted"

popd

# Remove Packages
pushd feeds/packages

popd


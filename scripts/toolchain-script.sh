#!/bin/bash
#=================================================
# Description: Toolchain script
# Lisence: MIT
# Author: helmiau (Helmi Amirudin)
# Blog: https://helmiau.com
#=================================================
# This script running at [Toolchain] job, after steps:  -> [Checkout] -> [Clone Source Code] -> [Generate Toolchain Config] -> [Generate Variables]
#=================================================

# Fix issue --Global symbol "@mrirors" requires explicit package name (did you forget to declare "my @mrirors"?) at tools/xz failed to build.
sed -i 's/mrirors/mirrors/g' $OPENWRT_ROOT_PATH/scripts/download.pl

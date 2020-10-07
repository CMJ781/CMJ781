#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
# Author: sirpdboy
# https://github.com/sirpdboy/Openwrt
#rm -rf ./package/lean/luci-theme-argon
rm -rf ./package/lean/trojan
rm -rf ./package/lean/v2ray
rm -rf ./package/lean/v2ray-plugin
rm -rf ./package/lean/luci-app-netdata
#rm -rf ./package/lean/luci-theme-opentomcat
#rm -rf ./feeds/packages/net/miniupnpd
rm -rf ./feeds/packages/net/mwan3
#rm -rf ./feeds/diy/adguardhome
rm -rf ./feeds/diy/smartdns
rm -rf ./feeds/packages/admin/netdata
rm -rf ./feeds/packages/net/smartdns
#rm -rf ./package/lean/autocore
rm -rf ./package/lean/default-settings
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
#sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
#sed -i 's/家庭云//g' package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i '/filter_/d' ./package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/192.168.1.1/192.168.8.250/g' ./package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/CMJ781-OpenWrt/g' ./package/base-files/files/bin/config_generate
sed -i 's/实时流量监测/监测/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/$(VERSION_DIST_SANITIZED)/$(shell date +%Y%m%d)/g' include/image.mk
#curl -fsSL https://raw.githubusercontent.com/siropboy/other/master/patch/luci-app-accesscontrol/luasrc/controller/mia.lua > ./package/lean/luci-app-accesscontrol/luasrc/controller/mia.lua
#curl -fsSL https://raw.githubusercontent.com/siropboy/other/master/patch/luci-app-accesscontrol/po/zh-cn/mia.po > ./package/lean/luci-app-accesscontrol/po/zh-cn/mia.po
#curl -fsSL https://raw.githubusercontent.com/siropboy/other/master/patch/luci-app-accesscontrol/luasrc/view/mia/mia_status.htm > ./package/lean/luci-app-accesscontrol/luasrc/view/mia/mia_status.htm
curl -fsSL  https://raw.githubusercontent.com/Lienol/openwrt-packages/dev-19.07/net/https-dns-proxy/files/https-dns-proxy.config > ./feeds/packages/net/https-dns-proxy/files/https-dns-proxy.config
curl -fsSL  https://raw.githubusercontent.com/Lienol/openwrt-packages/dev-19.07/net/https-dns-proxy/files/https-dns-proxy.init > ./feeds/packages/net/https-dns-proxy/files/https-dns-proxy.init
echo "DISTRIB_REVISION='S$(date +%Y.%m.%d) CMJ781'" > ./package/base-files/files/etc/openwrt_release1
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata/ ./feeds/packages/admin/netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata/ ./package/lean/luci-app-netdata
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/miniupnpd/ ./feeds/packages/net/miniupnpd
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/mwan3/ ./feeds/packages/net/mwan3
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/new/smartdns
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/adguardhome ./package/new/adguardhome
#svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ ./package/new/luci-app-jd-dailybonus
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/new/luci-app-serverchan
#git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/new/OpenAppFilter
git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash
#git clone -b master --single-branch https://github.com/frainzy1477/luci-app-clash ./package/new/luci-app-clash
#sed -i 's/), 5)/), 49)/g' package/new/luci-app-clash/luasrc/controller/clash.lua
#sed -i 's/), 1)/), 49)/g' package/new/luci-app-clash/luasrc/controller/clash.lua
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/new/luci-app-vssr
svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall package/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-package/trunk/package package/lienol
git clone -b 18.06 --single-branch https://github.com/garypang13/luci-theme-edge package/new/luci-theme-edge
git clone -b master --single-branch https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/new/luci-theme-infinityfreedom
git clone -b master --single-branch https://github.com/Leo-Jo-My/luci-theme-opentomato package/new/luci-theme-opentomato
git clone -b master --single-branch https://github.com/siropboy/luci-theme-btmod package/new/luci-theme-btmod
git clone -b 18.06 --single-branch https://github.com/jerrykuku/luci-theme-argon package/new/luci-theme-argon
git clone -b master --single-branch https://github.com/Leo-Jo-My/luci-theme-opentomcat package/new/luci-theme-opentomcat
./scripts/feeds update -i

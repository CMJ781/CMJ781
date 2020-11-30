#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
#rm -rf ./package/lean/luci-theme-argon
#rm -rf ./package/lean/luci-theme-opentomcat
#rm -rf ./package/lean/trojan
#rm -rf ./package/lean/v2ray
#rm -rf ./package/lean/v2ray-plugin

rm -rf ./feeds/packages/net/smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/diy/smartdns
#rm -rf ./package/lean/luci-app-netdata
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./package/lean/luci-app-netdata
#rm -rf ./feeds/packages/admin/netdata
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ./feeds/packages/admin/netdata
rm -rf ./feeds/packages/net/mwan3
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/mwan3 ./feeds/packages/net/mwan3
rm -rf ./feeds/packages/net/https-dns-proxy
svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy ./feeds/packages/net/https-dns-proxy

#rm -rf ./package/diy/netdata
rm -rf ./package/diy/mwan3
rm -rf ./package/lean/autocore
rm -rf ./package/lean/default-settings

sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
#sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
#sed -i 's/家庭云//g' package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i '/filter_/d' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/192.168.1.1/192.168.8.250/g' ./package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/CMJ781-OpenWrt/g' ./package/base-files/files/bin/config_generate
sed -i 's/实时流量监测/监测/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/$(VERSION_DIST_SANITIZED)/$(shell TZ=UTC-8 date +%Y%m%d)/g' include/image.mk
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template
echo "DISTRIB_REVISION='S$(TZ=UTC-8 date +%Y.%m.%d) CMJ781'" > ./package/base-files/files/etc/openwrt_release1
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow

#svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ ./package/diy/luci-app-jd-dailybonus
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/etc/serverchan > ./package/diy/luci-app-serverchan/root/etc/config/serverchan
#git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-openclash package/diy/luci-app-openclash
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/new/smartdns
#curl -fsSL https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-smartdns.conf >  ./package/new/smartdns/conf/anti-ad-smartdns.conf
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ package/diy/lienol
git clone -b master https://github.com/xiaorouji/openwrt-passwall.git package/lienol
git clone -b 18.06 --single-branch https://github.com/garypang13/luci-theme-edge package/new/luci-theme-edge
git clone -b master --single-branch https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/new/luci-theme-infinityfreedom
git clone -b master --single-branch https://github.com/Leo-Jo-My/luci-theme-opentomato package/new/luci-theme-opentomato
git clone -b master --single-branch https://github.com/siropboy/luci-theme-btmod package/new/luci-theme-btmod
git clone -b 18.06 --single-branch https://github.com/jerrykuku/luci-theme-argon package/new/luci-theme-argon
git clone -b master --single-branch https://github.com/Leo-Jo-My/luci-theme-opentomcat package/new/luci-theme-opentomcat

./scripts/feeds update -i

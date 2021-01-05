#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
rm -rf ./package/lean/luci-theme-argon
rm -rf ./package/lean/trojan
rm -rf ./package/lean/v2ray
rm -rf ./package/lean/v2ray-plugin
rm -rf ./package/lean/xray
#rm -rf ./package/lean/luci-theme-opentomcat
echo '替换smartdns'
rm -rf ./feeds/packages/net/smartdns&& \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/diy/smartdns

rm -rf ./feeds/packages/net/mwan3 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/mwan3 ./feeds/packages/net/mwan3

rm -rf ./feeds/packages/net/https-dns-proxy && \
svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy ./feeds/packages/net/https-dns-proxy

rm -rf ./package/diy/mwan3
rm -rf ./package/lean/autocore
rm -rf ./package/lean/default-settings

curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
#sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
#sed -i 's/家庭云//g' package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i 's/实时流量监测/流量/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
#sed -i 's/家庭云//g' package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
#sed -i 's/"BaiduPCS Web"/"百度网盘"/g' package/lean/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
#sed -i 's/cbi ("qbittorrent"),_("qBittorrent")/cbi ("qbittorrent"),_("BT 下载")/g' package/lean/luci-app-qbittorrent/luasrc/controller/qbittorrent.lua
#sed -i 's/"aMule 设置"/"电驴下载"/g' package/lean/luci-app-amule/po/zh-cn/amule.po
#sed -i 's/"KMS 服务器"/"KMS 激活"/g' package/lean/luci-app-vlmcsd/po/zh-cn/vlmcsd.zh-cn.po
#sed -i 's/"USB 打印服务器"/"打印服务"/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po

sed -i '/filter_/d' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/192.168.1.1/192.168.8.250/g' ./package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/CMJ781/g' ./package/base-files/files/bin/config_generate

sed -i 's/$(VERSION_DIST_SANITIZED)/$(shell TZ=UTC-8 date +%Y%m%d)/g' include/image.mk
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template
echo "DISTRIB_REVISION='S$(TZ=UTC-8 date +%Y.%m.%d) CMJ781'" > ./package/base-files/files/etc/openwrt_release1

sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow
sed -i 's/tables=1/tables=0/g' ./package/kernel/linux/files/sysctl-br-netfilter.conf
cp -f ./package/diy/banner ./package/base-files/files/etc/
sed -i '$a CONFIG_BINFMT_MISC=y' ./package/target/linux/x86/config-5.4

git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash
git clone https://github.com/xiaorouji/openwrt-passwall package/diy1
sed -i '$a\chdbits.co\n\www.cnscg.club\n\pt.btschool.club\n\et8.org\n\www.nicept.net\n\pthome.net\n\ourbits.club\n\pt.m-team.cc\n\hdsky.me\n\ccfbits.org' package/diy1/xiaorouji/luci-app-passwall/root/usr/share/passwall/rules/direct_host
sed -i '$a\docker.com\n\docker.io' package/diy1/xiaorouji/luci-app-passwall/root/usr/share/passwall/rules/proxy_host
sed -i '/global_rules/a	option auto_update 1\n	option week_update 0\n	option time_update 5' package/diy1/xiaorouji/luci-app-passwall/root/etc/config/passwall
sed -i '/global_subscribe/a	option auto_update_subscribe 1\noption week_update_subscribe 7\noption time_update_subscribe 5' package/diy1/xiaorouji/luci-app-passwall/root/etc/config/passwall

#git clone https://github.com/AlexZhuo/luci-app-bandwidthd diy/luci-app-bandwidthd
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/AdGuardHome ./package/new/AdGuardHome
#curl -fsSL https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-smartdns.conf >  ./package/new/smartdns/conf/anti-ad-smartdns.conf
#svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ ./package/diy/luci-app-jd-dailybonus
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/etc/serverchan > ./package/diy/luci-app-serverchan/root/etc/config/serverchan
#git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
#sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
#sed -i "/mediaurlbase/d" package/*/luci-theme*/root/etc/uci-defaults/*
#sed -i "/mediaurlbase/d" feed/*/luci-theme*/root/etc/uci-defaults/*
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-openclash package/diy/luci-app-openclash
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr

#rm -rf package/lean/luci-app-dockerman
#rm -rf package/lean/luci-lib-docker
rm -rf package/lean/luci-app-diskman
rm -rf package/lean/parted

#git clone -b 18.06 --single-branch https://github.com/garypang13/luci-theme-edge package/diy3/luci-theme-edge
#git clone -b master --single-branch https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/diy/luci-theme-infinityfreedom
#git clone -b master --single-branch https://github.com/Leo-Jo-My/luci-theme-opentomato package/diy/luci-theme-opentomato
#git clone -b master --single-branch https://github.com/siropboy/luci-theme-btmod package/diy/luci-theme-btmod
#git clone -b 18.06 --single-branch https://github.com/jerrykuku/luci-theme-argon package/diy/luci-theme-argon
#git clone -b master --single-branch https://github.com/Leo-Jo-My/luci-theme-opentomcat package/diy/luci-theme-opentomcat

./scripts/feeds update -i

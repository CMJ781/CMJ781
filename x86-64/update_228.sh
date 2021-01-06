#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
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

git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan

svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr

#git clone -b master --single-branch https://github.com/siropboy/luci-theme-btmod package/diy/luci-theme-btmod

./scripts/feeds update -i

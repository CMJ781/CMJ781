#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
rm -rf ./package/lean/trojan
rm -rf ./package/lean/v2ray
rm -rf ./package/lean/v2ray-plugin
rm -rf ./package/lean/xray

echo '替换smartdns'
rm -rf ./feeds/packages/net/smartdns&& \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/diy/smartdns

rm -rf ./feeds/packages/net/mwan3 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/mwan3 ./feeds/packages/net/mwan3

rm -rf ./feeds/packages/net/https-dns-proxy
svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy ./feeds/packages/net/https-dns-proxy

rm -rf ./package/diy/mwan3
rm -rf ./package/lean/autocore
rm -rf ./package/lean/default-settings

curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
#sed -i's/Turbo ACC 网络加速/网络加速 /g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
#sed -i's/家庭云//g' package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/实时流量监测/流量/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
#sed -i's/BaiduPCS Web/百度网盘/g' package/lean/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
#sed -i's/cbi ("qbittorrent"),_("qBittorrent")/cbi ("qbittorrent"),_("BT 下载")/g' package/lean/luci-app-qbittorrent/luasrc/controller/qbittorrent.lua
#sed -i's/aMule 设置/电驴下载/g' package/lean/luci-app-amule/po/zh-cn/amule.po
#sed -i's/KMS 服务器/KMS 激活/g' package/lean/luci-app-vlmcsd/po/zh-cn/vlmcsd.zh-cn.po
#sed -i's/USB 打印服务器/打印服务/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/192.168.1.1/192.168.8.250/g' ./package/base-files/files/bin/config_generate

cp -f ./package/diy/banner ./package/base-files/files/etc/
date1='Ipv6-S'`TZ=UTC-8 date +%Y.%m.%d -d +"0"days`
sed -i 's/$(VERSION_DIST_SANITIZED)/$(shell TZ=UTC-8 date +%Y%m%d)/g' include/image.mk
echo "DISTRIB_REVISION='${date1} by CMJ781'" > ./package/base-files/files/etc/openwrt_release1
echo ${date1}' by CMJ781 ' >> ./package/base-files/files/etc/banner
echo ' --------------------------------' >> ./package/base-files/files/etc/banner
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow

sed -i '/CONFIG_NVME_MULTIPATH /d' ./package/target/linux/x86/config-5.4
sed -i '/CONFIG_NVME_TCP /d' ./package/target/linux/x86/config-5.4
echo  'CONFIG_BINFMT_MISC=y' >> ./package/target/linux/x86/config-5.4
echo  'CONFIG_EXTRA_FIRMWARE="i915/kbl_dmc_ver1_04.bin"'   >> ./package/target/linux/x86/config-5.4
echo  'CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"'  >> ./package/target/linux/x86/config-5.4
echo  'CONFIG_NVME_FABRICS=y'  >> ./package/target/linux/x86/config-5.4
echo  'CONFIG_NVME_FC=y' >> ./package/target/linux/x86/config-5.4
echo  'CONFIG_NVME_MULTIPATH=y' >> ./package/target/linux/x86/config-5.4
echo  'CONFIG_NVME_TCP=y' >> ./package/target/linux/x86/config-5.4

git clone https://github.com/garypang13/luci-app-bypass.git package/diy/luci-app-bypass
#git clone https://github.com/garypang13/luci-app-dnsfilter.git package/diy/luci-app-dnsfilter
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/diy/luci-app-openclash
git clone https://github.com/xiaorouji/openwrt-passwall package/diy1
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr

./scripts/feeds update -i

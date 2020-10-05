#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
# Author: sirpdboy
# https://github.com/sirpdboy/Openwrt
#rm -rf ./package/new
# rm -rf ./package/lean/luci-theme-argon
#rm -rf ./package/lean/trojan
#rm -rf ./package/lean/v2ray
# rm -rf ./package/lean/luci-lib-docker
rm -rf ./package/lean/luci-theme-opentomcat
rm -rf ./feeds/diy/adguardhome
rm -rf ./feeds/diy/smartdns
rm -rf ./feeds/packages/admin/netdata
rm -rf ./feeds/packages/net/smartdns
sed -i 's/= "unreachable"/= "default"/g' ./feeds/luci/applications/luci-app-mwan3/luasrc/model/cbi/mwan/policyconfig.lua
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/default-settings/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
sed -i 's/网络存储/存储/g' ./package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/带宽监控/监控/g' ./feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' ./package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
# sed -i 's/Turbo ACC 网络加速/网络加速/g' ./package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' ./package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
# sed -i 's/家庭云//g' ./package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i '/filter_aaaa/d' ./package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/$(VERSION_DIST_SANITIZED)/$(shell date +%Y%m%d)-/g' ./include/image.mk
sed -i 's/实时流量监测/监测/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/192.168.1.1/192.168.8.250/g' ./package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/CMJ781-OpenWrt/g' ./package/base-files/files/bin/config_generate
curl -fsSL https://raw.githubusercontent.com/siropboy/other/master/patch/autocore/files/index.htm > ./package/lean/autocore/files/index.htm
# curl -fsSL https://raw.githubusercontent.com/siropboy/other/master/patch/luci-app-accesscontrol/luasrc/controller/mia.lua > ./package/lean/luci-app-accesscontrol/luasrc/controller/mia.lua
# curl -fsSL https://raw.githubusercontent.com/siropboy/other/master/patch/luci-app-accesscontrol/po/zh-cn/mia.po > ./package/lean/luci-app-accesscontrol/po/zh-cn/mia.po
# curl -fsSL https://raw.githubusercontent.com/siropboy/other/master/patch/luci-app-accesscontrol/luasrc/view/mia/mia_status.htm > ./package/lean/luci-app-accesscontrol/luasrc/view/mia/mia_status.htm
curl -fsSL  https://raw.githubusercontent.com/Lienol/openwrt-packages/dev-19.07/net/https-dns-proxy/files/https-dns-proxy.config > ./feeds/packages/net/https-dns-proxy/files/https-dns-proxy.config
curl -fsSL  https://raw.githubusercontent.com/Lienol/openwrt-packages/dev-19.07/net/https-dns-proxy/files/https-dns-proxy.init > ./feeds/packages/net/https-dns-proxy/files/https-dns-proxy.init
echo "DISTRIB_REVISION='S$(date +%Y.%m.%d) CMJ781'" > ./package/base-files/files/etc/openwrt_release1
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata/ ./feeds/packages/admin/netdata
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata/ ./package/lean/luci-app-netdata
svn co https://github.com/siropboy/other/trunk/patch/netdata feeds/packages/admin/netdata
svn co https://github.com/siropboy/other/trunk/patch/luci-app-netdata ./package/lean/luci-app-netdata
# svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ ./package/new/luci-app-jd-dailybonus
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/new/luci-app-serverchan
svn co https://github.com/siropboy/mypackages/trunk/smartdns ./package/new/smartdns
svn co https://github.com/siropboy/mypackages/trunk/adguardhome ./package/new/adguardhome
# svn co https://github.com/kenzok8/openwrt-packages/trunk/smartdns ./package/new/smartdns
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns ./package/new/luci-app-smartdns
# git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/new/OpenAppFilter
# svn co https://github.com/kenzok8/openwrt-packages/trunk/adguardhome ./package/new/AdGuardHome
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome ./package/new/luci-app-adguardhome
git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash
# git clone -b master --single-branch https://github.com/frainzy1477/luci-app-clash ./package/new/luci-app-clash
# sed -i 's/), 5)/), 49)/g' ./package/new/luci-app-clash/luasrc/controller/clash.lua
# sed -i 's/), 1)/), 49)/g' ./package/new/luci-app-clash/luasrc/controller/clash.lua
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  ./package/new/luci-app-vssr
svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall ./package/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-package/trunk/package ./package/lienol
# svn co https://github.com/siropboy/mypackages/trunk/luci-theme-opentopd ./package/lean/luci-theme-opentopd
# svn co https://github.com/siropboy/mypackages/trunk/luci-theme-argon_new ./package/lean/luci-theme-argon_new
# git clone -b master --single-branch https://github.com/jerrykuku/luci-theme-argon .package/new/luci-theme-argon
# git clone -b 18.06 --single-branch https://github.com/garypang13/luci-theme-edge package/new/luci-theme-edge
# git clone -b master --single-branch https://github.com//xiaoqingfengATGH/luci-theme-infinityfreedom package/new/luci-theme-infinityfreedom
git clone -b master --single-branch https://github.com/Leo-Jo-My/luci-theme-opentomato package/new/luci-theme-opentomato
svn co https://github.com/siropboy/mypackages/trunk/luci-theme-opentomcat ./package/new/luci-theme-opentomcat
# git clone -b master --single-branch https://github.com/Leo-Jo-My/luci-theme-opentomcat .package/new/luci-theme-opentomcat
# git clone  https://github.com/lisaac/luci-lib-docker.git package/new/luci-lib-docker
# git clone  https://github.com/lisaac/luci-app-dockerman.git package/new/luci-app-dockerman
# git clone https://github.com/NateLol/luci-app-beardropper package/new/luci-app-beardropper
# sed -i 's/"luci.fs"/"luci.sys".net/g' package/new/luci-app-beardropper/luasrc/model/cbi/beardropper/setting.lua
# sed -i '/firewall/d' package/new/luci-app-beardropper/root/etc/uci-defaults/luci-beardropper
# mv package/new/luci-app-beardropper/po/zh_Hans   package/new/luci-app-beardropper/po/zh-cn
# chmod +x  ./feeds/diy/luci-app-cpulimit/root/etc/init.d/c*
# chmod +x  ./feeds/diy/luci-app-cpulimit/root/usr/bin/c*
# chmod +x  ./feeds/diy/luci-app-autopoweroff/root/etc/init.d/a*
chmod +x  ./feeds/diy/luci-app-control-mia/root/etc/init.d/m*
chmod +x  ./feeds/diy/luci-app-control-mia/root/usr/share/rpcd/acl.d/l*
chmod +x  ./feeds/diy/luci-app-control-mia/root/etc/uci-defaults/l*
chmod +x  ./feeds/diy/luci-app-control-timewol/root/etc/init.d/t*
chmod +x  ./feeds/diy/luci-app-control-timewol/root/usr/share/rpcd/acl.d/l*
chmod +x  ./feeds/diy/luci-app-control-timewol/root/etc/uci-defaults/l*
chmod +x  ./feeds/diy/luci-app-control-webrestriction/root/etc/init.d/w*
chmod +x  ./feeds/diy/luci-app-control-webrestriction/root/etc/uci-defaults/l*
chmod +x  ./feeds/diy/luci-app-control-weburl/root/etc/init.d/w*
chmod +x  ./feeds/diy/luci-app-control-weburl/root/etc/uci-defaults/l*
# chmod +x  ./feeds/diy/luci-app-eqos/root/usr/sbin/e*
# chmod +x  ./feeds/diy/luci-app-eqos/root/etc/init.d/e*
# chmod +x  ./feeds/diy/luci-app-koolddns/root/etc/init.d/k*
# chmod +x  ./feeds/diy/luci-app-koolddns/root/usr/share/koolddns/a*
# chmod +x  ./feeds/diy/luci-app-koolddns/root/usr/share/koolddns/d*
# chmod +x  ./feeds/diy/luci-app-pptp-vpnserver-manyusers/root/etc/init.d/p*
# chmod +x  ./feeds/diy/luci-app-pptp-vpnserver-manyusers/root/usr/share/rpcd/acl.d/l*
# chmod +x  ./feeds/diy/luci-app-adguardhome/root/etc/init.d/A*
# chmod +x  ./feeds/diy/luci-app-adguardhome/root/etc/uci-defaults/4*
# chmod +x  ./feeds/diy/luci-app-adguardhome/root/usr/share/AdGuardHome/*.sh
chmod +x  ./feeds/diy/luci-app-smartdns/root/etc/uci-defaults/5*

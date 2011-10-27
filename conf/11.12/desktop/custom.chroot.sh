## Deepin LiveCD Build Tool 
## 冷罡华 (Hiweed) <hiweed@gmail.com>
## 张  成 (Stephen) <zhangcheng@linuxdeepin.com>

echo "[CUSTOM][CHROOT] Deleting unused locale files ..."
cat > /etc/local.nopurge <<EOF
MANDELETE
DONTBOTHERNEWLOCALE
SHOWFREEDSPACE
en_US                                                                               
en_US.ISO-8859-15                                                                   
en_US.UTF-8                                                                         
zh_CN                                                                               
zh_CN.GB18030                                                                       
zh_CN.GBK                                                                           
zh_CN.UTF-8                                                                         
zh_HK                                                                               
zh_HK.UTF-8                                                                         
zh_SG                                                                               
zh_SG.GBK                                                                           
zh_SG.UTF-8                                                                         
zh_TW                                                                               
zh_TW.EUC-TW                                                                        
zh_TW.UTF-8   
EOF

localepurge

echo "[CUSTOM][CHROOT] Mark all packages as manual installed ..."
aptitude unmarkauto ~M

#echo "[CUSTOM][CHROOT] Fix yozo office font issue ..."
#yz-fonts

echo "[CUSTOM][CHROOT] Deleting unused lanaguages ..."
LANGLIST='am ar ast be bg bn bs ca cs da de dz el eo es et eu fa fi fr ga gl gu he hi hr hu id is it ja ka kk km ko ku lt lv mk ml mr  nb ne nl nn no pa pl pt pt_br ro ru sk sl sq sr sv ta te th tl tr uk vi'
for i in $LANGLIST
do
    sed -i /$i\.utf-8:/d /var/cache/debconf/templates.dat
done

echo "[CUSTOM][CHROOT] Generating casper.conf ..."
cat > /etc/casper.conf <<EOF
export USERNAME="deepin"
export USERFULLNAME="Live session user"
export HOST="deepin"
export BUILD_SYSTEM="Deepin"
EOF

#echo "[CUSTOM][CHROOT] Fixing casper networking issue ..."
#cat > /tmp/23networking.patch <<EOF
#--- 23networking	2011-10-27 15:36:46.487840935 +0800
#+++ 23networking.new	2011-10-27 17:19:20.831735260 +0800
#@@ -78,11 +78,11 @@
#             # create a resolv.conf if it is not present
#             cp /tmp/net-"${DEVICE}".conf /root/var/log/netboot.config
#             #ipconfig quotes DNSDOMAIN, quotes need to be removed for a correct resolv.conf
#-            rc_search="$(sed -n 's/"//g;s/^DNSDOMAIN=//p' /tmp/net-"${DEVICE}".conf)"
#+            rc_search="$(sed -n 's/"//g;s/'\''//g;s/^DNSDOMAIN=//p' /tmp/net-"${DEVICE}".conf)"
#             #search might contain multiple entries but domain should only have one.
#-            rc_domain="$(sed -n -e 's/"//g;s/^DNSDOMAIN=\([^ ]\+\) *.*/\1/p'  /tmp/net-"${DEVICE}".conf)"
#-            rc_server0="$(sed -n 's/^IPV4DNS0=//p' /tmp/net-"${DEVICE}".conf)"
#-            rc_server1="$(sed -n 's/^IPV4DNS1=//p' /tmp/net-"${DEVICE}".conf)"
#+            rc_domain="$(sed -n -e 's/"//g;s/'\''//g;s/^DNSDOMAIN=\([^ ]\+\) *.*/\1/p'  /tmp/net-"${DEVICE}".conf)"
#+            rc_server0="$(sed -n 's/"//g;s/'\''//g;s/^IPV4DNS0=//p' /tmp/net-"${DEVICE}".conf)"
#+            rc_server1="$(sed -n 's/"//g;s/'\''//g;s/^IPV4DNS1=//p' /tmp/net-"${DEVICE}".conf)"
#             rc_server0="nameserver ${rc_server0}"
#             if [ "${rc_server1}" = "0.0.0.0" ]; then
#                 rc_server1=""
#EOF
#patch /usr/share/initramfs-tools/scripts/casper-bottom/23networking < /tmp/23networking.patch

echo "[CUSTOM][CHROOT] Set initramfs compress methos to lzma ..."
sed -i 's/COMPRESS=gzip/COMPRESS=lzma/g' /etc/initramfs-tools/initramfs.conf

## 最后需要 update-initramfs
update-initramfs -u

# vim:set ts=8 sts=4 sw=4 ft=sh:

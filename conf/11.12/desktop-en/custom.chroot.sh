## Deepin LiveCD Build Tool 
## 冷罡华 (Hiweed) <hiweed@gmail.com>
## 张  成 (Stephen) <zhangcheng@linuxdeepin.com>

echo "[CUSTOM][CHROOT] Deleting unused locale files ..."
cat > /etc/locale.nopurge <<EOF
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

[[ -x /usr/bin/updatedb ]] && /usr/bin/updatedb

echo "[CUSTOM][CHROOT] Deleting unused lanaguages ..."
LANGLIST='am ar ast be bg bn bs ca cs da de dz el eo es et eu fa fi fr ga gl gu he hi hr hu id is it ja ka kk km ko ku lt lv mk ml mr  nb ne nl nn no pa pl pt pt_br ro ru sk sl sq sr sv ta te th tl tr uk vi'
for i in $LANGLIST
do
    sed -i /$i\.utf-8:/d /var/cache/debconf/templates.dat
done

echo "[CUSTOM][CHROOT] Set initramfs compress methos to lzma ..."
sed -i 's/COMPRESS=gzip/COMPRESS=lzma/g' /etc/initramfs-tools/initramfs.conf

## 最后需要 update-initramfs
update-initramfs -u

# vim:set ts=8 sts=4 sw=4 ft=sh:

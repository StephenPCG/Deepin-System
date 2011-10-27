## Deepin LiveCD Build Tool 
## 冷罡华 (Hiweed) <hiweed@gmail.com>
## 张  成 (Stephen) <zhangcheng@linuxdeepin.com>

echo_and_log "[CUSTOM] Clean cache directories ..."
sudo rm -rf ${CHROOT_PATH}/var/cache/man/*
sudo rm -rf ${CHROOT_PATH}/var/cache/debconf/*old
sudo rm -rf ${CHROOT_PATH}/var/cache/apt-xapian-index/index*

if [[ -n "${OLD_SOURCES_LIST}" ]]; then
    echo "${OLD_SOURCES_LIST}" \
	| sudo tee "${CHROOT_PATH}/etc/apt/sources.list" > /dev/null
fi

# vim:set ts=8 sts=4 sw=4 ft=sh:

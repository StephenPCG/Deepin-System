## Deepin LiveCD Build Tool 
## 冷罡华 (Hiweed) <hiweed@gmail.com>
## 张  成 (Stephen) <zhangcheng@linuxdeepin.com>

echo_and_log "[CUSTOM] Clean cache directories ..."
sudo rm -rf ${CHROOT_PATH}/var/cache/man/*
sudo rm -rf ${CHROOT_PATH}/var/cache/debconf/*old
sudo rm -rf ${CHROOT_PATH}/var/cache/apt-xapian-index/index*
sudo rm -rf ${CHROOT_PATH}/tmp/*
## files in this dir is downloaded by debootstrap, we should not 
## clean them in chroot env, since APT_ARCHIVE_PATH is mounted
sudo rm -rf ${CHROOT_PATH}/var/cache/apt/archives/*.deb

# mkiso.conf.local may change the sources.list and apt_preferences file 
# to use local mirror site, change it back after the iso is built
OLD_SOURCES_LIST=${OLD_SOURCES_LIST:-}
if [[ -n "${OLD_SOURCES_LIST}" ]]; then
    echo "${OLD_SOURCES_LIST}" \
	| sudo tee "${CHROOT_PATH}/etc/apt/sources.list" > /dev/null
fi
OLD_APT_PREFERENCES=${OLD_APT_PREFERENCES:-}
if [[ -n "${OLD_APT_PREFERENCES}" ]]; then
    echo "${OLD_APT_PREFERENCES}" \
	| sudo tee "${CHROOT_PATH}/etc/apt/preferences" > /dev/null
fi

# Xsession customize
if [[ -n "${DEEPIN_XSESSION}"  ]]; then
    echo "${DEEPIN_XSESSION}" \
       | sudo tee "${CHROOT_PATH}/usr/share/xsessions/deepin.desktop" > /dev/null
fi
if [[ -n "${LIGHTDM_SESSION}"  ]]; then
    echo "${LIGHTDM_SESSION}" \
       | sudo tee "${CHROOT_PATH}/etc/lightdm/lightdm.conf" > /dev/null
fi

# vim:set ts=8 sts=4 sw=4 ft=sh:



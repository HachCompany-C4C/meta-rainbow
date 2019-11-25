#!/bin/sh

UPDATE_DIR="/tmp/pkg"
MCU_UPDATE_DIR="/tmp/mcu"
UPDATE_PACKAGES="Packages.tar.gz"
MCU_APP="firmware.bin"

if [ $# -lt 1 ]; then
	exit 0;
fi

function update_pkg() {
	if [ -f ${UPDATE_DIR}/${UPDATE_PACKAGES} ] ; then
		rm *.ipk > /dev/null 2>&1
		tar -xf ${UPDATE_DIR}/${UPDATE_PACKAGES} -C ${UPDATE_DIR}
		find  ${UPDATE_DIR} -name  "*.ipk" | xargs opkg --force-reinstall install
	else
		echo "Can't find apk packages, apps will not be updated"
	fi
}

function update_mcu()
{
	FIRMWARE=$MCU_UPDATE_DIR/${MCU_APP}
	if [ -f "$FIRMWARE" ] ; then
		/usr/bin/python /tmp/pkg/update_mcu.py
	else
		echo "Can't find firmware.bin, mcu will not be updated"
	fi
}


if [ $1 == "mcu" ]; then
	update_mcu
fi

if [ $1 == "pkg" ]; then
	update_pkg
fi

if [ $1 == "postinst" ]; then
	update_mcu
	update_pkg
    reboot
fi

if [ $1 == "preinst" ]; then
	echo "Begin update exec script"
fi

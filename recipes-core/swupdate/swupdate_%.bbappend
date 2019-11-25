FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://patch.cfg \
"

do_install_append() {
    rm ${D}${sysconfdir}/udev/rules.d/swupdate-usb.rules
    rm ${D}${systemd_unitdir}/system/swupdate-usb@.service
}

SYSTEMD_SERVICE_${PN}_remove = "swupdate-usb@.service"
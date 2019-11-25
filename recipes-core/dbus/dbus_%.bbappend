FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


SRC_URI += " \
    file://dbus.socket \
"

PACKAGECONFIG_append = "  user-session"

do_install_append() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/dbus.socket ${D}${systemd_unitdir}/system
}

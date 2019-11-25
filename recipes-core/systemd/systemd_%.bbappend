FILESEXTRAPATHS_prepend := "${THISDIR}/systemd:"

SRC_URI += " \
    file://wired.network \
    file://system.conf \
    file://journald.conf \
"

PACKAGECONFIG_append = " networkd"

do_install_append() {
    # The network files need to be in /usr/lib/systemd, not ${systemd_unitdir}...
    install -d ${D}${prefix}/lib/systemd/network/
    install -d ${D}/etc/systemd/network/
    install -m 0644 ${WORKDIR}/wired.network ${D}/etc/systemd/network/
    rm ${D}${sysconfdir}/systemd/system/getty.target.wants/getty@tty1.service
}

do_install_append() {
    install -d ${D}${sysconfdir}/systemd
    install -m 0644 ${WORKDIR}/system.conf ${D}/etc/systemd/
}

FILES_${PN} += " \
    ${nonarch_base_libdir}/systemd/network \
    ${sysconfdir}/systemd/system.conf \
"

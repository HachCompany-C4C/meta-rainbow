FILESEXTRAPATHS_prepend := "${THISDIR}/openssh:"

SRC_URI += " \
    file://sshd_config \
"

do_install_append() {
    install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/sshd_config ${D}${sysconfdir}/ssh/
}

FILES_${PN} += " \
    ${sysconfdir}/ssh/sshd_config \
"

SUMMARY = "D-Bus user session message bus service"
DESCRIPTION = "D-Bus is a message bus system, a simple way for applications to talk to one another. In addition to interprocess communication, D-Bus helps coordinate process lifecycle; it makes it simple and reliable to code a \"single instance\" application or daemon, and to launch applications and daemons on demand when their services are needed."
HOMEPAGE = "http://dbus.freedesktop.org"
SECTION = "base"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI =  " \
    file://dbus-session.service \
    file://dbus-session.socket \
"

do_install() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/dbus-session.service ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/dbus-session.socket ${D}${systemd_unitdir}/system
}

NATIVE_SYSTEMD_SUPPORT = "1"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = " \
			dbus-session.service \
			dbus-session.socket \
			"

inherit systemd

SUMMARY = "Open Source Full Database Encryption for SQLite"
DESCRIPTION = "SQLCipher is an open source library that provides transparent, secure 256-bit AES encryption of SQLite database files."
# SECTION = "webos/libs"

DEPENDS = "tcl-native openssl"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3"

PV = "3.4.2"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit autotools

SRCREV = "c6f709fca81c910ba133aaf6330c28e01ccfe5f8"
SRC_URI = "git://github.com/${BPN}/${BPN}"

EXTRA_OECONF = "--disable-tcl CFLAGS=-DSQLITE_HAS_CODEC"
EXTRA_OEMAKE='"LIBTOOL=${STAGING_BINDIR_CROSS}/${HOST_SYS}-libtool"'

S = "${WORKDIR}/git"

VIRTUAL-RUNTIME_bash ?= "bash"
RDEPENDS_${PN}_append_class-target = " ${VIRTUAL-RUNTIME_bash}"

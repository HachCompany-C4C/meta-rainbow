SUMMARY = "Open Source Full Database Encryption for SQLite"
DESCRIPTION = "SQLCipher is an open source library that provides transparent, secure 256-bit AES encryption of SQLite database files."

DEPENDS = "sqlcipher"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit setuptools

SRCREV = "c1feffaad1ae56ff45e795b4dbb08be97e860906"
SRC_URI = "git://github.com/leapcode/${BPN}.git"

S = "${WORKDIR}/git"

VIRTUAL-RUNTIME_bash ?= "bash"
RDEPENDS_${PN}_append_class-target = " ${VIRTUAL-RUNTIME_bash}"

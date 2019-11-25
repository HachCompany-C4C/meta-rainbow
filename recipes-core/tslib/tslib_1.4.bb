SUMMARY = "An abstraction layer for touchscreen panel events"
DESCRIPTION = "Tslib is an abstraction layer for touchscreen panel \
events, as well as a filter stack for the manipulation of those events. \
Tslib is generally used on embedded devices to provide a common user \
space interface to touchscreen functionality."
HOMEPAGE = "http://tslib.org/"

AUTHOR = "Russell King w/ plugins by Chris Larson et. al."
SECTION = "base"
LICENSE = "LGPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=f30a9716ef3762e3467a2f62bf790f0a"

SRC_URI = "https://github.com/kergoth/tslib/releases/download/${PV}/tslib-${PV}.tar.xz;downloadfilename=tslib-${PV}.tar.xz \
           file://ts.conf \
           file://tslib.sh \
"

SRC_URI[md5sum] = "0b939fd1b4bdc212ef99297da1cd8ff1"
SRC_URI[sha256sum] = "ad0373f1dbfda27caec92cb10421227f226c79d160488f1ac915585ba947741f"

UPSTREAM_CHECK_URI = "https://github.com/kergoth/tslib/releases"

inherit autotools pkgconfig

EXTRA_OECONF = "--enable-shared --disable-h3600 --enable-input --disable-corgi --disable-collie --disable-mk712 --disable-arctic2 --disable-ucb1x00"

do_install_prepend() {
    install -m 0644 ${WORKDIR}/ts.conf ${S}/etc/ts.conf
}

do_install_append() {
    install -d ${D}${sysconfdir}/profile.d/
    install -m 0755 ${WORKDIR}/tslib.sh ${D}${sysconfdir}/profile.d/
}

RPROVIDES_tslib-conf = "libts-0.0-conf"

PACKAGES =+ "tslib-conf tslib-tests tslib-calibrate tslib-uinput"
DEBIAN_NOAUTONAME_tslib-conf = "1"
DEBIAN_NOAUTONAME_tslib-tests = "1"
DEBIAN_NOAUTONAME_tslib-calibrate = "1"
DEBIAN_NOAUTONAME_tslib-uinput = "1"

RDEPENDS_${PN} = "tslib-conf"
RRECOMMENDS_${PN} = "pointercal"

FILES_${PN}-dev += "${libdir}/ts/*.la"
FILES_tslib-conf = "${sysconfdir}/ts.conf ${sysconfdir}/profile.d/tslib.sh ${datadir}/tslib"
FILES_${PN} = "${libdir}/*.so.* ${libdir}/ts/*.so*"
FILES_tslib-calibrate += "${bindir}/ts_calibrate"
FILES_tslib-uinput += "${bindir}/ts_uinput"

FILES_tslib-tests = "${bindir}/ts_harvest ${bindir}/ts_print ${bindir}/ts_print_raw ${bindir}/ts_print_mt \
                     ${bindir}/ts_test ${bindir}/ts_test_mt ${bindir}/ts_verify ${bindir}/ts_finddev"

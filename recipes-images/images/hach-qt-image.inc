SUMMARY = "Hach Embedded Linux Qt image"

LICENSE = "CLOSED"

#start of the resulting deployable tarball name
export IMAGE_BASENAME = "Hach-Image"
IMAGE_NAME = "${MACHINE}_${IMAGE_BASENAME}"
#IMAGE_NAME_colibri-imx6-rainbow = "Colibri-Imx6_${IMAGE_BASENAME}"
#IMAGE_NAME_colibri-imx7-rainbow = "Colibri-Imx7_${IMAGE_BASENAME}"

SYSTEMD_DEFAULT_TARGET = "graphical.target"

#create the deployment directory-tree
require recipes-images/images/hach-image-fstype.inc

IMAGE_LINGUAS = "en-us"
#IMAGE_LINGUAS = "de-de fr-fr en-gb en-us pt-br es-es kn-in ml-in ta-in"

DISTRO_UPDATE_ALTERNATIVES ??= ""
ROOTFS_PKGMANAGE_PKGS ?= '${@oe.utils.conditional("ONLINE_PACKAGE_MANAGEMENT", "none", "", "${ROOTFS_PKGMANAGE} ${DISTRO_UPDATE_ALTERNATIVES}", d)}'

# CONMANPKGS ?= "connman connman-plugin-loopback connman-plugin-ethernet connman-plugin-wifi connman-client"

IMAGE_INSTALL += " \
    angstrom-packagegroup-boot \
    packagegroup-basic \
    udev-extra-rules \
    ${ROOTFS_PKGMANAGE_PKGS} \
    timestamp-service \
    packagegroup-base-extended \
"

require recipes-images/images/hach-extra.inc

IMAGE_DEV_MANAGER   = "udev"
IMAGE_INIT_MANAGER  = "systemd"
IMAGE_INITSCRIPTS   = " "
IMAGE_LOGIN_MANAGER = "busybox shadow"

inherit core-image
inherit populate_sdk_qt5

inherit extrausers

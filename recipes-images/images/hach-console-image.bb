SUMMARY = "Hach Embedded Linux Console Image"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3"

#start of the resulting deployable tarball name
export IMAGE_BASENAME = "Hach-Console-Image"
IMAGE_NAME = "${MACHINE}_${IMAGE_BASENAME}"


#create the deployment directory-tree
require recipes-images/images/hach-image-fstype.inc
#VIRTUAL-RUNTIME_init_manager = "systemd"
#DISTRO_FEATURES_BACKFILL_CONSIDERED = "sysvinit"

IMAGE_INSTALL = "packagegroup-core-boot packagegroup-base-extended ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_FEATURES = "${EXTRA_IMAGE_FEATURES}"

IMAGE_LINGUAS = ""


require recipes-images/images/hach-extra.inc

inherit core-image


IMAGE_ROOTFS_SIZE ?= "8192"
IMAGE_OVERHEAD_FACTOR ?= "1"

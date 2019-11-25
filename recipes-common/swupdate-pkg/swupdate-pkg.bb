DESCRIPTION = "Recipe generating SWU image for ipk packages"
SECTION = ""

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3"

# Add all local files to be added to the SWU
# sw-description must always be in the list.
# You can extend with scripts or wahtever you need
SRC_URI = " \
    file://sw-description \
    file://firmware.bin \
    file://update.sh \
    file://update_mcu.py \
    "



SWUPDATE_PACKAGES = "sqlcipher"


inherit swupdate-package

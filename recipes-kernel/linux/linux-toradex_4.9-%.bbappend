FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_DTS ??= ""

SRC_DTS_append_colibri-imx7-rainbow = "imx7d-colibri-emmc-rainbow.dts"
SRC_DTS_append_colibri-imx6-rainbow = "imx6dl-colibri-rainbow.dts"

SRC_URI_append = " \
            file://0001-Add-dts-in-makefile.patch \
            file://0002-Add-Simcom-PCIE-4G-module-driver.patch \
            file://0003-Add-pcf8563-clockoutput-enable-disable-option-in-dev.patch \
            file://${SRC_DTS} \
            "

do_cpdts() {

    if [ -f ${WORKDIR}/${SRC_DTS} ]; then
        cp ${WORKDIR}/${SRC_DTS} ${S}/arch/arm//boot/dts/ -f 
    fi
}

addtask cpdts before do_patch after do_unpack


COMPATIBLE_MACHINE = "mx6|mx7"
LOCALVERSION_append = "-r13"


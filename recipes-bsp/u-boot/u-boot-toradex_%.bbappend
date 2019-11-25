FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_colibri-imx6-rainbow =  " \ 
            file://0001-Add-config.patch \
            file://0002-Fix-lcd-backlight-pin.patch \
            file://0003-Remove-tty1-console.patch \
            "

SRC_URI_append_colibri-imx7-rainbow = " \
            file://0001-Add-rainbow-board-for-uboot.patch \
            file://0002-Fix-led-For-rainbow-board.patch \
            file://0003-Change-uart-console.patch \
            file://0004-Add-panic-timeout.patch \
            file://0005-Enable-distro.patch \
	    "
        
COMPATIBLE_MACHINE = "mx6|mx7"


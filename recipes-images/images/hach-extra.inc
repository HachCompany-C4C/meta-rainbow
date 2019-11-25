#additional packages to include in our Toradex images

# Copy Licenses to image /usr/share/common-licenses, on vybrid for flash size reasons only the manifest
COPY_LIC_MANIFEST ?= "1"
#Bug with several MACHINES build, license files for all arch packages stored wrongly
COPY_LIC_DIRS ?= "0"

#the following builds cross gdb and gdbserver
DEPENDS += "gdb-cross-${TARGET_ARCH}"

add_rootfs_version () {
    echo -n "${IMAGE_NAME} ${PV}" >> ${IMAGE_ROOTFS}/etc/issue
    echo " ${TDX_VERDATE}" | sed 's/-//' >>${IMAGE_ROOTFS}/etc/issue
    echo "" >> ${IMAGE_ROOTFS}/etc/issue

    echo "${MACHINE} 1.0" >> ${IMAGE_ROOTFS}/etc/hwrevision
}


RUNTIME_PYTHON_PACKAGE= " python \
                          python-pip \
                          python-dbus \
                          python-pyserial \ 
                          python-can \ 
                          python-argparse \
                          python-pygobject \ 
                          python-nose \
                          python-numpy "

# For all the packages that should be installed
IMAGE_INSTALL_append = " ${RUNTIME_PYTHON_PACKAGE} \
                         libmodbus \
                         rsync \
                         bash \
			             sqlcipher \
			             pysqlcipher \
			             "

RUNTIME_QT_PACKAGE = " qtbase \ 
                       qtbase-plugins \
                       qtdeclarative \
                       qtdeclarative-qmlplugins \
                       qtdeclarative-plugins \
                       qtcharts \
                       cinematicexperience \ 
                       qtquickcontrols \
                       qtquickcontrols2 \
                       qtdeclarative \ 
                       tslib \
                       tslib-calibrate \
                       tslib-tests \
                       pointercal \
                       screen \
			           "

RUNTIME_TOOLS_PACKAGE = "ethtool \
                         canutils \
                         mmc-utils-cos \
                         swupdate \
                         swupdate-www \
                         swupdate-tools \
                         "
                         
# add the rootfs version to the welcome banner
ROOTFS_POSTPROCESS_COMMAND += " add_rootfs_version;"


RUNTIME_DEBUG_PACKAGE = " gdbserver \
                          grep \
                          perf \
                        "
RUNTIME_APP_PACKAGE ?= ""

IMAGE_INSTALL_append = " ${RUNTIME_QT_PACKAGE} \
                         ${RUNTIME_TOOLS_PACKAGE} \
                         ${RUNTIME_APP_PACKAGE} \
                         ${RUNTIME_DEBUG_PACKAGE}  \
                       " 
IMAGE_INSTALL_remove = "eglinfo-x11"

# Add sdk package
TOOLCHAIN_HOST_TASK_append = " ${SDK_EXTRA_TOOLS}"
SDK_EXTRA_TOOLS = "nativesdk-cmake "

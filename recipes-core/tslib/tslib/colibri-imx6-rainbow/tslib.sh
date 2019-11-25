#!/bin/sh

if [ -e /dev/input/touchscreen0 ]; then
    TSLIB_TSDEVICE=/dev/input/touchscreen0

    export TSLIB_TSDEVICE
fi

export TSLIB_FBDEVICE=/dev/fb0
export TSLIB_CONFFILE=/etc/ts.conf
export TSLIB_CONSOLEDEVICE=none
export TSLIB_CALIBFILE=/etc/pointercal
export TSLIB_PLUGINDIR=/usr/lib/ts

# config qt runtime for shell debug
export QT_DEBUG_PLUGINS=1
export QT_QPA_EGLFS_NO_LIBINPUT=1
export QT_QPA_GENERIC_PLUGINS=tslib
export QT_QPA_EGLFS_TSLIB=1
export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/event0:invertx
# export QT_LOGGING_RULES=qt.qpa.input=true
export QT_EGLFS_IMX6_NO_FB_MULTI_BUFFER=1

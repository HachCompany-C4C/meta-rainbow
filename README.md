# meta-rainbow

Yocto BSP layer for the Rainbow boards.


## Description

This is the general hardware specific BSP overlay for the Rainbow device.

The core BSP part of meta-rainbow should work with different
OpenEmbedded/Yocto distributions and layer stacks, such as:

* Angstrom.
* Yocto/Poky.

## Dependencies

This layer depends on:

* URI: https://git.toradex.com/cgit/toradex-bsp-platform.git
  * branch: LinuxImageV2.8
  * revision: HEAD
* URI: https://github.com/sbabic/meta-swupdate.git
  * branch: master
  * revision: HEAD  


## Quick Start

1. Create a directory for your oe-core setup to live in and clone the dependences meta layers
2. Add this layer to bblayers.conf and the dependencies above
3. Set MACHINE in local.conf to one of the supported boards
4. bitbake `hach-console-image` to build the console image


## Maintainers

* Tim huang `<xhuang@hach.com>`

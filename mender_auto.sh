#!/bin/bash

# if command fails clean exit
set -e

# Intitialize the environment
. export

# Add Mender layers
bitbake-layers add-layer $(pwd)/../layers/meta-mender/meta-mender-core/
bitbake-layers add-layer $(pwd)/../layers/meta-mender-community/meta-mender-toradex-nxp/
bitbake-layers add-layer $(pwd)/../layers/meta-de
bitbake-layers add-layer $(pwd)/../layers/meta-aws
bitbake-layers add-layer $(pwd)/../layers/meta-openembedded/meta-webserver

# Apply Mender configuration to build environment
cat ../layers/meta-mender-community/templates/local.conf.append >> conf/local.conf
cat ../layers/meta-mender-community/meta-mender-toradex-nxp/templates/local.conf.append  >> conf/local.conf
echo "TORADEX_BSP_VERSION = \"toradex-bsp-${TORADEX_BSP_VERSION}\"" >> conf/local.conf

#sed -i '22 s/#MACHINE ?= "apalis-imx8" /MACHINE ?= "apalis-imx8"' build/conf/local.conf
sed -i '406 s/MENDER_STORAGE_TOTAL_SIZE_MB_apalis-imx8 = "2048"/MENDER_STORAGE_TOTAL_SIZE_MB_apalis-imx8 = "8092"/' /home/awadh/Experiments-main/test-yocto-image-automation/build/conf/local.conf
sed -i '$ i\LICENSE_FLAGS_WHITELIST="commercial"' /home/awadh/Experiments-main/test-yocto-image-automation/build/conf/local.conf
sed -i '$ i\MENDER_PARTITIONING_OVERHEAD_KB = "${@eval("(int((${MENDER_PARTITION_ALIGNMENT}-1)/1024)+1)*4")}"' /home/awadh/Experiments-main/test-yocto-image-automation/build/conf/local.conf
sed -i '$ i\IMAGE_INSTALL_append = " mender-connect"' /home/awadh/Experiments-main/test-yocto-image-automation/build/conf/local.conf
sed -i '$ i\MENDER_CONNECT_USER = "root"' /home/awadh/Experiments-main/test-yocto-image-automation/build/conf/local.conf
sed -i '$ i\MENDER_CONNECT_SHELL = "/bin/bash"' /home/awadh/Experiments-main/test-yocto-image-automation/build/conf/local.conf


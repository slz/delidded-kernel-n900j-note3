#!/bin/bash

. ./dl-build.inc

if BUILD_KERNEL && BUILD_RAMDISK && BUILD_BOOT_IMG; then
	if [ $MAKE_ZIP -eq 1 ]; then CREATE_ZIP; fi
	if [ $MAKE_TAR -eq 1 ]; then CREATE_TAR; fi
	echo "Finished!"
else
	echo "Error!"
	exit -1
fi

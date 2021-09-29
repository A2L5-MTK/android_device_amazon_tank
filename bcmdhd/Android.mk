# Copyright Statement:
#

LOCAL_PATH:=$(call my-dir)
LOCAL_PATH_FULL := $(shell pwd)
LOCAL_PATH_BCMDHD := $(call my-dir)

FULL_PATH_1 := $(LOCAL_PATH_FULL)/$(LOCAL_PATH_BCMDHD)

LOCAL_DIR:=$(call my-dir)
BUILD_DIR:=$(LOCAL_DIR)/build
TARGETDIR=$(KERNEL_MODULES_OUT)

###################################################################
# setting the path for cross compiler
###################################################################
LINUXVER:=3.10
KERNELDIR:=kernel/amazon/mt8127
CROSSTOOL:=prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/
LINUXDIR:=out/target/product/tank/obj/KERNEL_OBJ
# PATH:=${CROSSTOOL}:${LINUXDIR}:$PATH
CC:=arm-eabi-gcc
STRIP:=arm-eabi-strip
CROSS_COMPILE:=arm-eabi-

#These are for compiling under FOS
# export TARGET_ARCH=arm
# export CFLAGS=-w
#export LINUX_PORT=1

.PHONY: bcmdhd_module
bcmdhd_module: $(INSTALLED_KERNEL_TARGET) | $(KERNEL_OUT) $(KERNEL_MODULES_OUT) $(ACP)
	$(hide) rm -rf $(ANDROID_PRODUCT_OUT)/system/lib/modules/bcmdhd.ko
	$(MAKE) -C $(KERNEL_OUT) M=$(FULL_PATH_1) ARCH=$(TARGET_ARCH) CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) modules
	$(hide) cp -f $(FULL_PATH_1)/bcmdhd.ko $(KERNEL_MODULES_OUT)
	$(MAKE) -C $(KERNEL_OUT) M=$(FULL_PATH_1) ARCH=$(TARGET_ARCH) CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) clean

kernel-modules: bcmdhd_module

ALL_DEFAULT_INSTALLED_MODULES += bcmdhd_module

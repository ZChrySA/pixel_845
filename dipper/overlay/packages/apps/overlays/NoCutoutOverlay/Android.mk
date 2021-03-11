LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_RRO_THEME := DisplayCutoutNoCutout
LOCAL_CERTIFICATE := platform

LOCAL_SRC_FILES := $(call all-subdir-java-files)

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res

LOCAL_PACKAGE_NAME := NoCutoutOverlay
LOCAL_SDK_VERSION := current

LOCAL_VENDOR_MODULE := true

include $(BUILD_RRO_PACKAGE)

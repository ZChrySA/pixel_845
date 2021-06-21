#
# Copyright (C) 2016 The Android Open-Source Project
# Copyright (C) 2018-2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_VENDOR := xiaomi

BUILD_BROKEN_DUP_RULES := true

BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

BUILD_BROKEN_VINTF_PRODUCT_COPY_FILES := true

LOCAL_PATH := device/xiaomi/dipper

# TODO(b/131162102): remove this after cleaning up accesses of sysprops
BUILD_BROKEN_TREBLE_SYSPROP_NEVERALLOW := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := kryo385

TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm845
TARGET_NO_BOOTLOADER := true

# HOLY CTS LORDS - Don't patch plz google
BOARD_KERNEL_CMDLINE += androidboot.verifiedbootstate=green
# HOLY CTS LORDS - Don't patch plz google

BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 androidboot.console=ttyMSM0 earlycon=msm_geni_serial,0xA84000 androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=2048
BOARD_KERNEL_CMDLINE += androidboot.configfs=true
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3
BOARD_KERNEL_CMDLINE += androidboot.hardware.dsds=1
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem

BOARD_BOOT_HEADER_VERSION := 1
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
TARGET_KERNEL_ARCH := arm64

# Platform
TARGET_BOARD_PLATFORM := sdm845
TARGET_BOARD_PLATFORM_GPU := qcom-adreno630

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Audio
AUDIO_FEATURE_ENABLED_AAC_ADTS_OFFLOAD := true
AUDIO_FEATURE_ENABLED_AUDIOSPHERE := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS := true
AUDIO_FEATURE_ENABLED_HDMI_SPK := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true
USE_XML_AUDIO_POLICY_CONF := 1
TARGET_USES_QCOM_MM_AUDIO := true

# Bluetooth
# TODO(b/123695868): Remove the need for this
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := build/make/target/board/mainline_arm64/bluetooth
BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_USES_COMMON_BLUETOOTH_HAL := true

# Charger Mode
BOARD_CHARGER_ENABLE_SUSPEND := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Filesystem
TARGET_FS_CONFIG_GEN := $(LOCAL_PATH)/config.fs

# Graphics
TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true
TARGET_USES_ION := true

VSYNC_EVENT_PHASE_OFFSET_NS := 2000000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 6000000

# Display
TARGET_HAS_WIDE_COLOR_DISPLAY := true
TARGET_HAS_HDR_DISPLAY := true
TARGET_USES_DISPLAY_RENDER_INTENTS := true
TARGET_USES_COLOR_METADATA := true
TARGET_USES_DRM_PP := true

# HIDL
DEVICE_MANIFEST_FILE := $(LOCAL_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(LOCAL_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := device/xiaomi/dipper/device_framework_matrix.xml
# Install device framework compatibility matrix to product partition
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE := device/xiaomi/dipper/device_framework_matrix_product.xml

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67092480
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57453555712
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_ROOT_EXTRA_SYMLINKS := \
    /mnt/vendor/persist:/persist \
    /vendor/bt_firmware:/bt_firmware \
    /vendor/dsp:/dsp \
    /vendor/firmware_mnt:/firmware

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
TARGET_USES_MKE2FS := true

TARGET_COPY_OUT_VENDOR := vendor

TARGET_COPY_OUT_PRODUCT := system/product

TARGET_COPY_OUT_SYSTEM_EXT := system/system_ext

BOARD_USES_METADATA_PARTITION := true

# Power
TARGET_POWERHAL_MODE_EXT := $(LOCAL_PATH)/power/power-mode.cpp

# QCOM
BOARD_USES_QCOM_HARDWARE := true
QCOM_BOARD_PLATFORMS += sdm845
MSM_VIDC_TARGET_LIST := sdm845

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"

# RenderScript
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Sepolicy
include device/xiaomi/dipper-sepolicy/dipper-sepolicy.mk

# Sound Trigger
BOARD_SUPPORTS_SOUND_TRIGGER := true
SOUND_TRIGGER_FEATURE_LPMA_ENABLED := true

# Treble
BOARD_VNDK_VERSION := current
PRODUCT_FULL_TREBLE_OVERRIDE := true

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE:= true
WIFI_FEATURE_IMU_DETECTION := false
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# Enable system property split for Treble
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Inherit from the proprietary version
-include vendor/xiaomi/sdm845-common/BoardConfigVendor.mk

#
# Copyright (C) 2016 The Android Open-Source Project
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

LOCAL_PATH := device/xiaomi/dipper

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/xiaomi/beryllium-kernel/Image.gz-dtb
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += $(LOCAL_KERNEL):kernel

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/beryllium/overlay

PRODUCT_PACKAGES += \
    NoCutoutOverlay

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Inherit from common
$(call inherit-product, device/xiaomi/dipper/device-common.mk)

# Manifest
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/manifest_keymaster_3_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/manifest_keymaster_3_0.xml

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/beryllium/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/beryllium/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/beryllium/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/beryllium/mixer_paths_overlay_dynamic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_dynamic.xml \
    $(LOCAL_PATH)/beryllium/mixer_paths_overlay_static.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_static.xml \
    $(LOCAL_PATH)/beryllium/sound_trigger_mixer_paths_wcd9340.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths_wcd9340.xml \
    $(LOCAL_PATH)/beryllium/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.camera.perfcapture=1 \
    ro.qcamera.manufacturer=Xiaomi

# Device fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.beryllium:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom

# Device init scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/beryllium/init.beryllium.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.beryllium.rc

# Display density
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=440

# Display postprocessing
PRODUCT_PROPERTY_OVERRIDES += \
    persist.ppd.fde.config=0 \
    vendor.display.enable_default_color_mode=1

# Fingerprint
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.fp.fpc=true \
    ro.hardware.fp.goodix=true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/manifest_goodix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/manifest_goodix.xml

# GNSS
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.overlay.izat.optin=rro

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/manifest_qcom_gnss.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/manifest_qcom_gnss.xml

# Haha yes this device has external sdcard :')
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

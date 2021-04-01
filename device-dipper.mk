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
    LOCAL_KERNEL := device/xiaomi/dipper-kernel/Image.gz-dtb
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += $(LOCAL_KERNEL):kernel

# Manifest
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/manifest_keymaster_4_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/manifest_keymaster_4_0.xml

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/dipper/overlay

PRODUCT_PACKAGES += \
    NoCutoutOverlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Inherit from common
$(call inherit-product, device/xiaomi/dipper/device-common.mk)

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/dipper/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/dipper/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/dipper/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/dipper/mixer_paths_overlay_dynamic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_dynamic.xml \
    $(LOCAL_PATH)/dipper/mixer_paths_overlay_static.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_static.xml \
    $(LOCAL_PATH)/dipper/sound_trigger_mixer_paths_wcd9340.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths_wcd9340.xml \
    $(LOCAL_PATH)/dipper/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.audio.soundfx.type=mi

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qcamera.manufacturer=Xiaomi \
    persist.camera.sat.fallback.dist=45 \
    persist.camera.sat.fallback.dist.d=5 \
    persist.camera.sat.fallback.luxindex=405 \
    persist.camera.sat.fallback.lux.d=20

# Display density
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=440

# Display postprocessing
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.display.enable_default_color_mode=0

# Device fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.dipper:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom

# Device init scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/dipper/init.dipper.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.dipper.rc

# Fingerprint
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.fp.fpc=true \
    ro.hardware.fp.goodix=true

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/manifest_goodix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/manifest_goodix.xml

# GPS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/dipper/gps_debug.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/gps_debug.conf \
    $(LOCAL_PATH)/dipper/gps_diag.cfg:$(TARGET_COPY_OUT_SYSTEM)/etc/gps_diag.cfg

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.flp=brcm \
    ro.hardware.gps=brcm

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/manifest_brcm_gnss.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/manifest_brcm_gnss.xml

# Power
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/powerhint_early_wakeup.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

include device/xiaomi/dipper/nfc/nfc.mk

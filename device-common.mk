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

PRODUCT_SHIPPING_API_LEVEL := 27

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

LOCAL_PATH := device/xiaomi/dipper

# define hardware platform
PRODUCT_PLATFORM := sdm845

include device/xiaomi/dipper/device.mk

# Bug 77867216
PRODUCT_PROPERTY_OVERRIDES += audio.adm.buffering.ms=3
PRODUCT_PROPERTY_OVERRIDES += vendor.audio.adm.buffering.ms=3
PRODUCT_PROPERTY_OVERRIDES += audio_hal.period_multiplier=2
PRODUCT_PROPERTY_OVERRIDES += af.fast_track_multiplier=1

# Enable HW Codec 2.0 as default service
# Set all codec components are available with their normal ranks
# Set OMX components's default rank large than Codec 2.0 HW components's default rank (0x100)
PRODUCT_PROPERTY_OVERRIDES += debug.stagefright.ccodec=4
PRODUCT_PROPERTY_OVERRIDES += debug.stagefright.omx_default_rank=512

# AUX packagelist
PRODUCT_PROPERTY_OVERRIDES += vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.google.android.GoogleCameraEng

# Setting vendor SPL
VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Set boot SPL
BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# A2DP offload supported
PRODUCT_PROPERTY_OVERRIDES += \
ro.bluetooth.a2dp_offload.supported=true

# A2DP offload disabled (UI toggle property)
PRODUCT_PROPERTY_OVERRIDES += \
persist.bluetooth.a2dp_offload.disabled=false

# A2DP offload DSP supported encoder list
PRODUCT_PROPERTY_OVERRIDES += \
persist.bluetooth.a2dp_offload.cap=sbc-aac-aptx-aptxhd-ldac

# BPF
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.ebpf.supported=true

# Vulkan
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.vulkan=adreno

# Enable iorapd perfetto tracing for app starts
PRODUCT_PRODUCT_PROPERTIES += \
    iorapd.perfetto.enable=true
# Enable iorapd readahead for app starts
PRODUCT_PRODUCT_PROPERTIES += \
    iorapd.readahead.enable=true

# whitelisted app
PRODUCT_COPY_FILES += \
    device/xiaomi/dipper/qti_whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/qti_whitelist.xml

# Set thermal warm reset
PRODUCT_PRODUCT_PROPERTIES += \
    ro.thermal_warmreset = true \

# Modem logging file
PRODUCT_COPY_FILES += \
    device/xiaomi/dipper/init.logging.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(PRODUCT_PLATFORM).logging.rc

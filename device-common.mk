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

# whitelisted app
PRODUCT_COPY_FILES += \
    device/xiaomi/dipper/qti_whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/qti_whitelist.xml

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

LOCAL_PATH := device/xiaomi/dipper/beryllium

# Partitions
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864

# Power
TARGET_TAP_TO_WAKE_NODE := "/dev/input/event2"

# Recovery
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/../fstab.beryllium

# Display
BOARD_PANEL_MAX_BRIGHTNESS := 4095
TARGET_USES_DRM_PP := true

# Firmware update
TARGET_RELEASETOOLS_EXTENSIONS := device/xiaomi/beryllium-radio

# Inherit from common
include device/xiaomi/dipper/BoardConfig-common.mk

# Inherit from the proprietary version
-include vendor/xiaomi/beryllium/BoardConfigVendor.mk

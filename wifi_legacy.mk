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

TARGET_USES_LEGACY_WIFI := true

PRODUCT_SOONG_NAMESPACES += \
    device/xiaomi/dipper/wifi_legacy

CNSS := cnss-daemon
PRODUCT_PACKAGES += $(CNSS)

PRODUCT_COPY_FILES += \
    device/xiaomi/dipper/wifi_legacy/libqmi_cci_xiaomi.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmi_cci_xiaomi.so:qti
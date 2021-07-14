/*
 * Copyright (C) 2019 The Android Open Source Project
 * Copyright (C) 2020 The PixelExperience Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "android.hardware.lights-service.xiaomi_sdm845"

#include "Lights.h"
#include <log/log.h>
#include <android-base/logging.h>
#include <fstream>

namespace aidl {
namespace android {
namespace hardware {
namespace light {

/*
 * Write value to path and close file.
 */
template <typename T>
static void set(const std::string& path, const T& value) {
    std::ofstream file(path);
    file << value;
}

/*
 * Read from path and close file.
 * Return def in case of any failure.
 */
template <typename T>
static T get(const std::string& path, const T& def) {
    std::ifstream file(path);
    T result;

    file >> result;
    return file.fail() ? def : result;
}

static constexpr int kDefaultMaxBrightness = 255;

static constexpr uint32_t kBrightnessNoBlink = 5;

static uint32_t rgbToBrightness(const HwLightState& state) {
    uint32_t color = state.color & 0x00ffffff;
    return ((77 * ((color >> 16) & 0xff))
            + (150 * ((color >> 8) & 0xff))
            + (29 * (color & 0xff))) >> 8;
}

const static std::map<LightType, int> kSupportedLights = {
    {LightType::BACKLIGHT, 3},
    {LightType::BATTERY, 2},
    {LightType::NOTIFICATIONS, 1},
    {LightType::ATTENTION, 0}
};

Lights::Lights() {
    // int lightCount = 0;
    for (auto const &pair : kSupportedLights) {
        LightType type = pair.first;
        int priority = pair.second;
        HwLight hwLight{};
        hwLight.id = (int)type;
        hwLight.type = type;
        hwLight.ordinal = 0;
        mLights[hwLight.id] = priority;
        mAvailableLights.emplace_back(hwLight);
    }
}

ndk::ScopedAStatus Lights::setLightState(int id, const HwLightState& state) {
    ALOGI("setLightState id=%d", id);
    auto it = mLights.find(id);
    if (it == mLights.end()) {
        ALOGE("Light not supported");
        return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
    }

    if (id == (int)LightType::BACKLIGHT) {
        int maxBrightness = get("/sys/class/backlight/panel0-backlight/max_brightness", -1);
        if (maxBrightness < 0) {
            maxBrightness = kDefaultMaxBrightness;
        }
        uint32_t sentBrightness = rgbToBrightness(state);
        uint32_t brightness = sentBrightness * maxBrightness / kDefaultMaxBrightness;
        LOG(DEBUG) << "Writing backlight brightness " << brightness
                << " (orig " << sentBrightness << ")";
        set("/sys/class/backlight/panel0-backlight/brightness", brightness);
        return ndk::ScopedAStatus::ok();
    }

    std::lock_guard<std::mutex> lock(mLock);

    mHwLightStates.at(mLights[id]) = state;
    uint32_t whiteBrightness = 0;
    // choose HwLightState in the order of priority
    HwLightState stateToUse = mHwLightStates.front();
    for (const auto& itState : mHwLightStates) {
        if (itState.color & 0xffffff) {
            stateToUse = itState;
            whiteBrightness = kBrightnessNoBlink;
            break;
        }
    }

    uint32_t onMs = stateToUse.flashMode == FlashMode::TIMED ? stateToUse.flashOnMs : 0;
    uint32_t offMs = stateToUse.flashMode == FlashMode::TIMED ? stateToUse.flashOffMs : 0;

    // Disable blinking to start
    set("/sys/class/leds/white/blink", 0);

    if (onMs > 0 && offMs > 0) {
        // Start blinking
        set("/sys/class/leds/white/blink", 1);
    } else {
        set("/sys/class/leds/white/brightness", whiteBrightness);
    }

    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus Lights::getLights(std::vector<HwLight>* lights) {
    for (auto i = mAvailableLights.begin(); i != mAvailableLights.end(); i++) {
        lights->push_back(*i);
    }
    return ndk::ScopedAStatus::ok();
}

}  // namespace light
}  // namespace hardware
}  // namespace android
}  // namespace aidl

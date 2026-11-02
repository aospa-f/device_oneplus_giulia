/*
 * SPDX-FileCopyrightText: 2026 The AOSPA Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include <android-base/logging.h>
#include <binder/ProcessState.h>
#include <hidl/HidlTransportSupport.h>
#include <utils/Errors.h>

#include <codec2/hidl/1.0/ComponentStore.h>

#include <memory>

namespace android {
std::shared_ptr<C2ComponentStore> GetCodec2DolbyComponentStore();
}

using android::hardware::media::c2::V1_0::IComponentStore;
using android::hardware::media::c2::V1_0::utils::ComponentStore;

int main() {
    android::ProcessState::initWithDriver("/dev/vndbinder");
    android::hardware::configureRpcThreadpool(1, true);

    std::shared_ptr<C2ComponentStore> store =
            android::GetCodec2DolbyComponentStore();
    if (!store) {
        LOG(ERROR) << "Unable to create the Dolby Codec2 component store";
        return 1;
    }

    android::sp<IComponentStore> service = new ComponentStore(store);
    if (service->registerAsService("default1") != android::OK) {
        LOG(ERROR) << "Unable to register the Dolby Codec2 service";
        return 1;
    }

    LOG(INFO) << "Dolby Codec2 service started";
    android::hardware::joinRpcThreadpool();
    return 0;
}

#
# Copyright (C) 2021-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Alert slider
PRODUCT_PACKAGES += \
    KeyHandler \
    tri-state-key-calibrate

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 2780
TARGET_SCREEN_WIDTH := 1264

# Display
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/displayconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630946652107814787.xml

# Dolby Vision
$(call soong_config_set_bool,dolby_vision,target_supports_dolby_vision,true)

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0-service \
    hwservicemanager

# Init
PRODUCT_PACKAGES += \
    init.haptics.rc

# OnePlus Settings
PRODUCT_PACKAGES += \
    OnePlusSettings

# OPlus Camera
$(call inherit-product-if-exists, vendor/oplus/camera/giulia/opluscamera.mk)

# Face unlock
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.biometrics.face.xml

# Fingerprint
$(call soong_config_set_bool,qtidisplay,oplus_udfps,true)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-custom

PRODUCT_PACKAGES += \
    FrameworksResEuicc_EU \
    FrameworksResEuicc_NA \
    FrameworksResEuicc_ROW \
    KeyHandlerResTarget \
    OnePlusSettingsResTarget \
    OPlusFrameworksResTarget \
    OPlusSettingsProviderResTarget \
    OPlusSettingsResTarget \
    OPlusSystemUIResTarget \
    OPlusWifiResTarget

# Regional properties
REGIONAL_PROP_FILES := $(wildcard $(LOCAL_PATH)/properties/*/*.prop)

PRODUCT_COPY_FILES += $(foreach f,$(REGIONAL_PROP_FILES), \
    $(f):$(TARGET_COPY_OUT_ODM)/etc/$(patsubst $(LOCAL_PATH)/properties/%,%,$(f)) \
    $(f):$(TARGET_COPY_OUT_RECOVERY)/root/vendor/odm/etc/$(patsubst $(LOCAL_PATH)/properties/%,%,$(f)))

# Sensors
$(call soong_config_set,oplus_sensors,uses_als_capture,true)

PRODUCT_PACKAGES += \
    vendor.lineage.oplus_als.service

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 35

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Telephony
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

$(call soong_config_set,qti_vibrator,use_effect_stream,true)
$(call soong_config_set,qti_vibrator,use_effect_stream_strength,true)
$(call soong_config_set,qti_vibrator,use_primitive_effect_stream,true)
$(call soong_config_set,qti_vibrator,effect_lib,libqtivibratoreffect.oplus_sm8650-richtap)

# WiFi firmware symlinks
PRODUCT_PACKAGES += \
    firmware_wlan_mac.bin_symlink \
    firmware_WCNSS_qcom_cfg.ini_symlink

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/oneplus/sm8650-common/common.mk)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/oneplus/giulia/giulia-vendor.mk)

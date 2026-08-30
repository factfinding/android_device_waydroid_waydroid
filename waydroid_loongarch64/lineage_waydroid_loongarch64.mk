#
# Copyright (C) 2026 The Waydroid Project
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

# LoongArch64 is a 64-bit-only architecture.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# The target host uses 16 KiB pages. This also aligns ARM64 native-bridge
# binaries so their Bionic page-protected globals can be mapped correctly.
PRODUCT_MAX_PAGE_SIZE_SUPPORTED := 16384
PRODUCT_NO_BIONIC_PAGE_SIZE_MACRO := true
PRODUCT_16K_DEVELOPER_OPTION := true

# ARM64 native-bridge libraries commonly use 4 KiB ELF segment alignment.
# Unlike native processes, the guest linker cannot inherit the per-process
# compatibility mode selected by Zygote, so enable Bionic's 16 KiB app-compat
# loader globally for this fixed-16-KiB-page product.
PRODUCT_SYSTEM_PROPERTIES += \
    bionic.linker.16kb.app_compat.enabled=true

# ARM64 native-bridge code currently runs through Berberis' interpreter.  A
# cold translated process can legitimately need tens of seconds to finish
# bindApplication, so use Android's standard slow-emulator timeout scaling.
PRODUCT_SYSTEM_PROPERTIES += \
    ro.hw_timeout_multiplier=5

# Inherit the common Waydroid device configuration.
$(call inherit-product, $(LOCAL_PATH)/../device.mk)

# Reuse the official ARM64 GApps prebuilts through the ARM64 native bridge.
# Keep libjni_latinimegoogle out of the product: unlike the APK-owned guest
# libraries, Soong installs it as a target /product/lib64 library and the
# native LoongArch64 LatinIME process would try to load it as a host ELF.
ANDROID_USE_GAPPS ?= true
ifeq ($(ANDROID_USE_GAPPS),true)
PRODUCT_SOONG_NAMESPACES += \
    vendor/gapps/arm64

PRODUCT_PACKAGES += \
    GmsCore \
    Phonesky \
    MarkupGoogle_v2 \
    SetupWizard \
    SpeechServicesByGoogle \
    Velvet \
    talkback

$(call inherit-product, vendor/gapps/common/common-vendor.mk)
endif

# ARM64 native libraries are executed by the interpreter-only LoongArch64
# Berberis port.
$(call inherit-product, frameworks/libs/binary_translation/enable_arm64_to_loongarch64.mk)

# ART has no compiler backend for LoongArch64 yet.
WITH_DEXPREOPT := false

# The host runtime has no LoongArch64 libbcc backend. Keep RenderScript out of
# the native Zygote, but allow ARM64 applications to initialize the guest
# runtime lazily through Berberis.
PRODUCT_PRODUCT_PROPERTIES += \
    config.disable_renderscript=1

# Provide a self-contained virtual modem so Android's standard telephony APIs
# can expose per-instance identifiers without a host modem or data connection.
PRODUCT_PACKAGES += \
    com.android.hardware.radio.minradio.virtual

PRODUCT_VENDOR_PROPERTIES += \
    ro.telephony.default_network=13

# Present a conventional mobile device profile to applications while keeping
# PRODUCT_NAME and PRODUCT_DEVICE stable as the internal Waydroid build target.
PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=graceltexx \
    DeviceProduct=2509FPN0BC \
    ProductModel=2509FPN0BC

PRODUCT_BRAND := XIAOMI
PRODUCT_DEVICE := waydroid_loongarch64
PRODUCT_MANUFACTURER := XIAOMI
PRODUCT_NAME := lineage_waydroid_loongarch64
PRODUCT_MODEL := 2509FPN0BC

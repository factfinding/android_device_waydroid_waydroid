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

# Inherit the common Waydroid device configuration.
$(call inherit-product, $(LOCAL_PATH)/../device.mk)

# ARM64 native libraries are executed by the interpreter-only LoongArch64
# Berberis port.
$(call inherit-product, frameworks/libs/binary_translation/enable_arm64_to_loongarch64.mk)

# ART has no compiler backend for LoongArch64 yet.
WITH_DEXPREOPT := false

# The legacy RenderScript runtime depends on libbcc's LLVM backend, which does
# not support LoongArch64. Keep framework class preloading from initializing it.
PRODUCT_PRODUCT_PROPERTIES += \
    config.disable_renderscript=1

PRODUCT_BRAND := waydroid
PRODUCT_DEVICE := waydroid_loongarch64
PRODUCT_MANUFACTURER := Waydroid
PRODUCT_NAME := lineage_waydroid_loongarch64
PRODUCT_MODEL := WayDroid LoongArch64 Device

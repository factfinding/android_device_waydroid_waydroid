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

# Inherit the common Waydroid device configuration.
$(call inherit-product, $(LOCAL_PATH)/../device.mk)

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

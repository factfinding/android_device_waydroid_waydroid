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

-include device/waydroid/waydroid/BoardConfig.mk

# Architecture
TARGET_ARCH := loongarch64
TARGET_ARCH_VARIANT :=
TARGET_CPU_ABI := loongarch64
# Keep accepting APKs produced during early bring-up. lp64d names the
# LoongArch psABI rather than the Android application ABI.
TARGET_CPU_ABI2 := lp64d
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH :=
TARGET_2ND_ARCH_VARIANT :=
TARGET_2ND_CPU_ABI :=
TARGET_2ND_CPU_ABI2 :=
TARGET_2ND_CPU_VARIANT :=

AUDIOSERVER_MULTILIB := first

ifneq ($(TARGET_USE_MESA),false)
BOARD_MESA3D_GALLIUM_VA := disabled
BOARD_MESA3D_VIDEO_CODECS := all
endif

# Keep bring-up moving while architecture coverage is completed.
ALLOW_MISSING_DEPENDENCIES := true

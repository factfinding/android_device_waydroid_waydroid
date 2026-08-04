LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := RemovePackages
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := AudioFX Bluetooth BluetoothMidiService
ifeq ($(TARGET_ARCH),loongarch64)
# Chromium WebView does not provide Android prebuilts for LoongArch64 yet.
# Omit both the unavailable provider and its advertised system feature so
# SystemServer does not start WebViewUpdateService without a provider.
LOCAL_OVERRIDES_PACKAGES += \
    android.software.webview.prebuilt.xml \
    webview
endif
LOCAL_UNINSTALLABLE_MODULE := true
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := /dev/null
include $(BUILD_PREBUILT)

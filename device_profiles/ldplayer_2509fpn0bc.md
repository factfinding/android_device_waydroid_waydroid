# LDPlayer `2509FPN0BC` reference profile

Captured through the LDPlayer-bundled ADB on 2026-08-07. Unique identifiers
(Android ID, serial, IMEI/MEID, IMSI, ICCID and advertising identifiers) are
intentionally excluded. This is a compatibility reference, not proof of a real
device identity.

## Public product identity

```text
ro.product.brand=XIAOMI
ro.product.manufacturer=XIAOMI
ro.product.model=2509FPN0BC
ro.product.name=2509FPN0BC
ro.product.device=graceltexx
ro.product.board=2509FPN0BC
ro.build.characteristics=tablet
```

## Build identity reported by the emulator

```text
ro.build.version.release=14
ro.build.version.sdk=34
ro.build.version.security_patch=2024-02-05
ro.build.fingerprint=OnePlus/graceltexx/graceltexx:14/UQ1A.240205.07291809/ucsm.20260729.180903:user/release-keys
ro.build.description=graceltexx-user 14 UQ1A.240205.07291809 ucsm.20260729.180903 release-keys
ro.product.first_api_level=28
```

The identity is internally inconsistent: the public product is Xiaomi, the
fingerprint is OnePlus, and the system/vendor/odm partition product properties
report `Google/AOSP`. Do not copy the fingerprint into the Android 16 Waydroid
image; doing so would also falsely report a different OS version and patch
level.

## Runtime and graphics

```text
kernel=5.15.178+ x86_64
page_size=4096
primary_abi=x86_64
abilist=x86_64,arm64-v8a,x86,armeabi-v7a,armeabi
native_bridge=libhoudini.so
hardware=qcom
egl=adreno
vulkan=adreno
GLES=Qualcomm, Adreno (TM) 750, OpenGL ES 3.1 v1
display=2560x1440@320dpi
```

The guest `/proc/cpuinfo` exposes the host Intel Core i5-13600KF and the
`hypervisor` CPU flag, so LDPlayer is not hiding its virtualization boundary.
Waydroid must retain its real LoongArch64 ABI, page size, Mesa/radeonsi driver,
and Berberis Native Bridge properties.

## Selected framework features

LDPlayer advertises telephony, GPS/network location, Wi-Fi, Bluetooth, NFC,
camera (including FULL/RAW/manual capabilities), fingerprint, microphone,
accelerometer, gyroscope, compass, barometer, light/proximity sensors, Vulkan,
OpenGL ES AEP, freeform windows, WebView and Google Experience features.

Runtime inspection only found an `LSM330 Accelerometer` in SensorService. The
radio is Android VSoC RIL with a synthetic LTE operator, and the battery is a
fixed AC/USB-powered 85%. Feature declarations therefore substantially exceed
the implemented hardware.

## Safe Waydroid subset

Only the public presentation fields in
[`ldplayer_2509fpn0bc_sanitized.prop`](ldplayer_2509fpn0bc_sanitized.prop) are
suitable for an optional compatibility profile. Do not override ABI, kernel,
page size, Native Bridge, EGL/Vulkan, verified boot, security patch level,
telephony, DRM, attestation or unique identifiers.


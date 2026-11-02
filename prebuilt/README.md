# Giulia vendor prebuilts

## android.hardware.media.c2@1.0.so

- **Source:** Ronard's OnePlus 13R (`giulia`) OxygenOS 16 vendor image, 2026-10-27
- **Size:** 568080 bytes
- **SHA-256:** `552a2510e0627089a6c8002595bb862d894566afa8f24e24c15179056ca7e9c3`
- **Why this copy:** The AOSPA source-built HIDL interface library crashes the
  Sony Dolby C2 service with a null `getPoolClientManager` result. The stock
  16.0.10.600 library fails its CFI check against AOSPA's `libhidlbase`.
  Ronard's library is built without CFI and was verified on giulia to decode
  E-AC3 through `c2.dolby.eac3.decoder` without crashing the service.

Installed by `device/oneplus/giulia/Android.bp` and `device.mk`.

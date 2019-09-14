#!/bin/bash
#Shell script to pull a specific xml file
'<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="DirtyUnicorns/android_device_google_marlin" path="device/google/marlin" remote="github" revision="p9x" />
  <project name="DirtyUnicorns/android_kernel_google_marlin" path="kernel/google/marlin" remote="github" revision="p9x" />
  <project name="DirtyUnicorns/android_vendor_google" path="vendor/google" remote="github" revision="p9x" />
  <project name="DirtyUnicorns/android_vendor_pixelgapps" path="vendor/pixelgapps" remote="gitlab" revision="p9x" />
  <project name="DirtyUnicorns/android_device_google_bonito" path="device/google/bonito" remote="github" revision="p9x" />
  <project name="DirtyUnicorns/android_device_google_bonito-sepolicy" path="device/google/bonito-sepolicy" remote="github" revision="p9x" />
  <project name="DirtyUnicorns/android_kernel_google_bonito" path="kernel/google/bonito" remote="github" revision="p9x" />
</manifest>' >>/home/centurion/Documents/local_manifest

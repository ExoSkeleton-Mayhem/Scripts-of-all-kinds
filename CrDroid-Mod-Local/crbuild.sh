#!/bin/bash
#script to start your rom build for bacon
echo . build/envsetup.sh
echo lunch lineage_marlin-userdebug && mka bacon
echo ITS ON THE WAY!!!

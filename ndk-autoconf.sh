#!/bin/bash
# Script to instsall and configure ndk
echo "Lets Install NDK and Configure. Note: You will have to manualy change the NDK tool you wish to use, all files are included for such a task!"
git clone https://github.com/glennrp/libpng
cd libpng
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG
export AR=$TOOLCHAIN/bin/aarch64-linux-android-ar
export AS=$TOOLCHAIN/bin/aarch64-linux-android-as
export CC=$TOOLCHAIN/bin/aarch64-linux-android21-clang
export CXX=$TOOLCHAIN/bin/aarch64-linux-android21-clang++
export LD=$TOOLCHAIN/bin/aarch64-linux-android-ld
export RANLIB=$TOOLCHAIN/bin/aarch64-linux-android-ranlib
export STRIP=$TOOLCHAIN/bin/aarch64-linux-android-strip
./configure --host aarch64-linux-android
make -y

#!/bin/bash
# Script to non-auto_conf android ndk toolchain
git clone https://gitlab.com/teocosta84/bzip2.git
cd bzip2
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG
make \
    CC=$TOOLCHAIN/bin/armv7a-linux-androideabi16-clang \
    AR=$TOOLCHAIN/bin/arm-linux-androideabi-ar \
    RANLIB=$TOOLCHAIN/bin/arm-linux-androideabi-ranlib \
    bzip2

#!/usr/bin/env bash

cd /tmp || exit 1
git clone https://github.com/WestCoastRomS/ccache.git
cd ccache
./autogen.sh
./configure --disable-man
make -j"$(nproc)"
sudo make install
rm -rf "${PWD}"
cd - || exit 1

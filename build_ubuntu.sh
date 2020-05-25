#! /bin/bash

set -ex

sudo apt-get update

sudo apt-get install mailutils texinfo liblockfile-dev librsvg2-dev dbus-x11 libgif-dev libtiff-dev libsystemd-dev xaw3dg-dev libjpeg-dev libm17n-dev libotf-dev libgpm-dev libdbus-1-dev quilt debhelper libxaw7-dev sharutils imagemagick libgtk-3-dev libgnutls28-dev libxml2-dev libselinux1-dev libasound2-dev libmagick++-6.q16-dev libacl1-dev -y

sudo apt-get install libgccjit-10-dev gcc-10 -y

export CC=gcc-10

./autogen.sh
if [ "$BUILD_NATIVECOMP" == "yes" ]; then
    ./configure --with-nativecomp --prefix $PWD/emacs-installation --enable-checking
else
    ./configure --prefix $PWD/emacs-installation --enable-checking
fi

make -j$(nproc)

make install

if [ "$BUILD_NATIVECOMP" == "yes" ]; then
    tar cJf emacs-nativecomp-$BUILD_BITS.tar.xz emacs-installation
else
    tar cJf emacs-$BUILD_BITS.tar.xz emacs-installation
fi

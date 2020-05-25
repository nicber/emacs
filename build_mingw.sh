#! /bin/bash

echo $PATH

function windowsdep {
  pacman --noconfirm -S --needed mingw-w64-$MSYS2_ARCH-$1
}

function msysdep {
  pacman --noconfirm -S --needed $1
}

set -e

pacman --noconfirm -S --needed base-devel zip

ls -lh /

# rem Install the relevant native dependencies
# windowsdep gcc
msysdep libbz2
windowsdep cairo
windowsdep dbus
windowsdep expat
windowsdep fontconfig
windowsdep gdk-pixbuf2
windowsdep giflib
windowsdep gnutls
windowsdep jansson
windowsdep libffi
windowsdep librsvg
windowsdep libxml2
windowsdep lcms2

gcc -v

version=`
  sed -n 's/^AC_INIT(GNU Emacs,[	 ]*\([^	 ,)]*\).*/\1/p' <configure.ac
` || version=
if [ ! "${version}" ]; then
  printf '%s\n' \
    "${progname}: can't find current Emacs version in './src/emacs.c'" >&2
  exit 1
fi

destdir=emacs-$version

mkdir -p $destdir/bin

# from lisp/term/w32-win.el
# cp /$MSYSTEM/bin/libxpm.dll $destdir/bin
# cp /$MSYSTEM/bin/xpm4.dll $destdir/bin
# cp /$MSYSTEM/bin/libXpm-nox4.dll $destdir/bin
cp /$MSYSTEM/bin/libpng16-16.dll $destdir/bin
cp /$MSYSTEM/bin/libtiff-5.dll $destdir/bin
cp /$MSYSTEM/bin/libjpeg-8.dll $destdir/bin
cp /$MSYSTEM/bin/libgif-7.dll $destdir/bin
cp /$MSYSTEM/bin/librsvg-2-2.dll $destdir/bin
cp /$MSYSTEM/bin/libgdk_pixbuf-2.0-0.dll $destdir/bin
cp /$MSYSTEM/bin/libglib-2.0-0.dll $destdir/bin
cp /$MSYSTEM/bin/libgio-2.0-0.dll $destdir/bin
cp /$MSYSTEM/bin/libgobject-2.0-0.dll $destdir/bin
cp /$MSYSTEM/bin/libgnutls-30.dll $destdir/bin
cp /$MSYSTEM/bin/libxml2-2.dll $destdir/bin
cp /$MSYSTEM/bin/zlib1.dll $destdir/bin
cp /$MSYSTEM/bin/liblcms2-2.dll $destdir/bin
cp /$MSYSTEM/bin/libjansson-4.dll $destdir/bin
# libgccjit.dll")))

./autogen.sh

./configure --prefix=$PWD/$destdir

cd src/

make -j$(nproc)

# make install

# zip -r emacs.zip $destdir

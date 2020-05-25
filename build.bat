rem Needs the following vars:
rem    MSYS2_ARCH:  x86_64 or i686
rem    MSYSTEM:  MINGW64 or MINGW32

rem Set the paths appropriately
IF "%BUILD_BITS%" == "64" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
echo 64-bit...
set MSYSTEM=MINGW64
set MSYS2_ARCH=x86_64
GOTO BUILD

:32BIT
echo 32-bit...
set MSYSTEM=MINGW32
set MSYS2_ARCH=i686
GOTO BUILD

:BUILD

PATH C:\msys64\%MSYSTEM%\bin;C:\msys64\usr\local\bin;C:\msys64\usr\bin;C:\msys64\bin;%PATH%

pacman --noconfirm --sync --refresh --refresh pacman
pacman --noconfirm --sync --refresh --refresh --sysupgrade --sysupgrade

bash build_mingw.sh
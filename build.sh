wget -q https://dl.google.com/android/repository/android-ndk-r21d-linux-x86_64.zip
unzip android-ndk-r21d-linux-x86_64.zip > /dev/null
wget -q ftp://sourceware.org/pub/libffi/libffi-3.3.tar.gz
tar zxvf libffi-3.3.tar.gz > /dev/null
wget -q https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tar.xz
tar -xvJf Python-3.9.1.tar.xz > /dev/null
cd Python-3.9.1
./configure
make
make install
make clean
cd ..
export MYPATH=$(dirname $(readlink -f "$0"))
export Host=linux-x86_64
export NDK=$MYPATH/android-ndk-r21d
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$Host
export TARGET=aarch64-linux-android
export API=21
export AR=$TOOLCHAIN/bin/$TARGET-ar
export AS=$TOOLCHAIN/bin/$TARGET-as
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/$TARGET-ld
export RANLIB=$TOOLCHAIN/bin/$TARGET-ranlib
export STRIP=$TOOLCHAIN/bin/$TARGET-strip
export READELF=$TOOLCHAIN/bin/$TARGET-readelf
cd libffi-3.3
./configure --host=x86_64-linux -build=$TARGET
make
export CFLAGS=$CFLAGS -I$MYPATH/libffi-3.3/$TARGET/include
export LDFLAGS=$LDFLAGS -L$MYPATH/libffi-3.3/$TARGET -static
export LINKFORSHARED=""
cd ..
cd Python-3.9.1
./configure --host=x86_64-linux --build=$TARGET --disable-ipv6 ac_cv_file__dev_ptmx=no ac_cv_file__dev_ptc=no
make

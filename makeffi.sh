export MYPATH=$(dirname $(readlink -f "$0"))
export Host=linux-x86_64
export NDK=$MYPATH/android-ndk-r21d
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$Host
export TARGET=$1
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
./configure --host=$TARGET
make
export CFLAGS=$CFLAGS -I$MYPATH/libffi-3.3/$TARGET/include
export LDFLAGS=$LDFLAGS -L$MYPATH/libffi-3.3/$TARGET -static
export LINKFORSHARED=""
cd ..

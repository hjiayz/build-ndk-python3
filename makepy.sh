export MYPATH=$(dirname $(readlink -f "$0"))
export Host=linux-x86_64
export NDK=$MYPATH/android-ndk-r22
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$Host
export TARGET=$1
if test -z "$2"
then
  export CC_TARGET=$1
else  
  export CC_TARGET=$2
fi
export CLANGTARGET=
export API=21
export AR=$TOOLCHAIN/bin/$TARGET-ar
export AS=$TOOLCHAIN/bin/$TARGET-as
export CC=$TOOLCHAIN/bin/$CC_TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$CC_TARGET$API-clang++
export LD=$TOOLCHAIN/bin/$TARGET-ld
export RANLIB=$TOOLCHAIN/bin/$TARGET-ranlib
export STRIP=$TOOLCHAIN/bin/$TARGET-strip
export READELF=$TOOLCHAIN/bin/$TARGET-readelf
export CFLAGS=-I$MYPATH/libffi-3.3/$TARGET/include -I$TOOLCHAIN/sysroot/usr/include
export LDFLAGS=-L$MYPATH/libffi-3.3/$TARGET -static
export LINKFORSHARED=""
cd Python-3.9.1
./configure --host=x86_64-linux -build=$CC_TARGET --disable-ipv6 ac_cv_file__dev_ptmx=no ac_cv_file__dev_ptc=no
make
cd ..

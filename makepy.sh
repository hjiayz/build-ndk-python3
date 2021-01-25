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
export CLANGTARGET=" "
export API=29
export AR=$TOOLCHAIN/bin/$TARGET-ar
export AS=$TOOLCHAIN/bin/$TARGET-as
export CC=$TOOLCHAIN/bin/$CC_TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$CC_TARGET$API-clang++
export LD=$TOOLCHAIN/bin/$TARGET-ld
export RANLIB=$TOOLCHAIN/bin/$TARGET-ranlib
export STRIP=$TOOLCHAIN/bin/$TARGET-strip
export READELF=$TOOLCHAIN/bin/$TARGET-readelf
export CFLAGS="-I$MYPATH/libffi-3.3/$TARGET/include -fPIC"
export LDFLAGS="-L$MYPATH/libffi-3.3/$TARGET"
# export LINKFORSHARED=" "
cd Python-3.9.1
export PREFIXPATH=$MYPATH/zip-dir/$TARGET
./configure --host=$CC_TARGET --target=$CC_TARGET --build=x86_64-linux  --disable-ipv6 ac_cv_file__dev_ptmx=no ac_cv_file__dev_ptc=no --with-openssl=$MYPATH/openssl-dir --prefix=$PREFIXPATH
make
make install
make clean
cd ..

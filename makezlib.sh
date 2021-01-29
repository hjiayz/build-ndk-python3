wget http://zlib.net/zlib1211.zip
unzip zlib1211.zip
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
export API=29
export AR=$TOOLCHAIN/bin/$TARGET-ar
export AS=$TOOLCHAIN/bin/$TARGET-as
export CC=$TOOLCHAIN/bin/$CC_TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$CC_TARGET$API-clang++
export LD=$TOOLCHAIN/bin/$TARGET-ld
export RANLIB=$TOOLCHAIN/bin/$TARGET-ranlib
export STRIP=$TOOLCHAIN/bin/$TARGET-strip
export READELF=$TOOLCHAIN/bin/$TARGET-readelf
cd zlib-1.2.11
export ABI=armeabi-v7a
export TARGET=armv7a-linux-androideabi
cmake \
    -B${MYPATH}/zlib_file/$TARGET
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_NATIVE_API_LEVEL=$API \
make
make install
make clean
export ABI=arm64-v8a
export TARGET=aarch64-linux-android
cmake \
    -B${MYPATH}/zlib_file/$TARGET
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_NATIVE_API_LEVEL=$API \
make
make install
make clean
export ABI=x86
export TARGET=i686-linux-android
cmake \
    -B${MYPATH}/zlib_file/$TARGET
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_NATIVE_API_LEVEL=$API \
make
make install
make clean
export ABI=x86_64
export TARGET=x86_64-linux-android
cmake \
    -B${MYPATH}/zlib_file/$TARGET
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_NATIVE_API_LEVEL=$API \
make
make install
make clean
cd ..

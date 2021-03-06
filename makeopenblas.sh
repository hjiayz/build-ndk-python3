export MYPATH=$(dirname $(readlink -f "$0"))
export Host=linux-x86_64
export NDK=$MYPATH/android-ndk-r22
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$Host

wget https://github.com/xianyi/OpenBLAS/archive/v0.3.13.zip
unzip v0.3.13.zip
cd OpenBLAS-0.3.13

make clean
make \
    TARGET=ARMV7 \
    ONLY_CBLAS=1 \
    CC="$TOOLCHAIN"/bin/armv7a-linux-androideabi29-clang \
    AR="$TOOLCHAIN"/bin/arm-linux-androideabi-ar \
    HOSTCC=gcc \
    ARM_SOFTFP_ABI=1 \
    -j4
make install PREFIX=$MYPATH/zip-dir/openblas/arm-linux-androideabi

make clean
make \
    TARGET=CORTEXA57 \
    ONLY_CBLAS=1 \
    CC=$TOOLCHAIN/bin/aarch64-linux-android29-clang \
    AR=$TOOLCHAIN/bin/aarch64-linux-android-ar \
    HOSTCC=gcc \
    -j4
make install PREFIX=$MYPATH/zip-dir/openblas/aarch64-linux-android

make clean
make \
    TARGET=ATOM \
    ONLY_CBLAS=1 \
    CC="$TOOLCHAIN"/bin/i686-linux-android29-clang \
    AR="$TOOLCHAIN"/bin/i686-linux-android-ar \
    HOSTCC=gcc \
    ARM_SOFTFP_ABI=1 \
    -j4
make install PREFIX=$MYPATH/zip-dir/openblas/i686-linux-android

# This will build for x86_64 
make clean
make \
    TARGET=ATOM BINARY=64\
    ONLY_CBLAS=1 \
    CC="$TOOLCHAIN"/bin/x86_64-linux-android29-clang \
    AR="$TOOLCHAIN"/bin/x86_64-linux-android-ar \
    HOSTCC=gcc \
    ARM_SOFTFP_ABI=1 \
    -j4
make install PREFIX=$MYPATH/zip-dir/openblas/x86_64-linux-android

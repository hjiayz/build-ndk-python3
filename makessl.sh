export MYPATH=$(dirname $(readlink -f "$0"))
export NDK=$MYPATH/android-ndk-r22
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$Host
export TARGET=$1
cd openssl-1.1.1i
PATH=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin:$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:$PATH
./Configure $TARGET -D__ANDROID_API__=29
make
ls
cd ..

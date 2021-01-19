export MYPATH=$(dirname $(readlink -f "$0"))
export NDK=$MYPATH/android-ndk-r22
export ANDROID_NDK_ROOT=$MYPATH/android-ndk-r22
export ANDROID_NDK_HOME=$MYPATH/android-ndk-r22
export ANDROID_NDK=$MYPATH/android-ndk-r22
export TOOLCHAIN=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/$Host
export TARGET=$1
git clone https://github.com/hjiayz/openssl.git
cd openssl
git checkout igtd/android-ndk-r22
export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin:$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:$PATH
./Configure $TARGET -D__ANDROID_API__=29
make
ls
cd ..

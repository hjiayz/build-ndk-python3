export MYPATH=$(dirname $(readlink -f "$0"))
export Host=linux-x86_64
export NDK=$MYPATH/android-ndk-r22
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$Host
export TARGET=$1
export PATH=$PATH:$MYPATH/build/python/bin
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
./configure --host=$CC_TARGET --target=$CC_TARGET --build=x86_64-linux  --disable-ipv6 ac_cv_file__dev_ptmx=no ac_cv_file__dev_ptc=no --with-openssl=$MYPATH/openssl-dir --without-ensurepip --prefix=$PREFIXPATH
make
make install
make clean
cd ..
$MYPATH/build/python/bin/python3 -m pip install pip
pip install crossenv
$MYPATH/build/python/bin/python3 --version
$MYPATH/build/python/bin/python3 -m crossenv --sysroot $TOOLCHAIN/sysroot $PREFIXPATH/bin/python3 $PREFIXPATH/venv
source $PREFIXPATH/venv/bin/activate
build-pip install cython wheel cffi
pip download numpy
unzip -q ./numpy*
rm numpy*zip
cd numpy*
python3 setup.py install
cd ..
rm -rf numpy*
pip download --no-binary scipy
unzip -q ./scipy*
rm scipy*zip
cd scipy*
python3 setup.py install
cd ..
rm -rf scipy*
pip download --no-binary pandas
unzip -q ./pandas*
rm pandas*zip
cd pandas*
python3 setup.py install
cd ..
rm -rf pandas*
pip download --no-binary pandas
unzip -q ./pandas*
rm pandas*zip
cd pandas*
python3 setup.py install
cd ..
rm -rf pandas*
pip download --no-binary sympy
unzip -q ./sympy*
rm sympy*zip
cd sympy*
python setup.py install
cd ..
rm -rf sympy*
pip download --no-binary nose
unzip -q ./nose*
rm nose*zip
cd nose*
python setup.py install
cd ..
rm -rf nose*

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
$MYPATH/build/python/bin/pip3 install crossenv
$MYPATH/build/python/bin/python3 --version
$MYPATH/build/python/bin/python3 -m crossenv --sysroot $TOOLCHAIN/sysroot $PREFIXPATH/bin/python3 $PREFIXPATH/venv
source $PREFIXPATH/venv/bin/activate
build-pip install cython wheel cffi
ls
mkdir $PREFIXPATH/venv/src
cd $PREFIXPATH/venv/src
ls
export NPY_BLAS_ORDER=
export NPY_LAPACK_ORDER=
export LDFLAGS="-lm"
pip download  --no-binary :all: --src $PREFIXPATH/venv/src numpy
unzip -q ./numpy*
rm numpy*zip
cd numpy*
python3 setup.py install
cd ..
rm -rf numpy*
pip download --no-binary :all: --src $PREFIXPATH/venv/src scipy
unzip -q ./scipy*
rm scipy*zip
cd scipy*
python3 setup.py install
cd ..
rm -rf scipy*
pip download --no-binary :all: --src $PREFIXPATH/venv/src pandas
unzip -q ./pandas*
tar xzvf ./pandas*
rm pandas*zip
cd pandas*
python3 setup.py install
cd ..
rm -rf pandas*
pip download --no-binary :all: --src $PREFIXPATH/venv/src sympy
unzip -q ./sympy*
tar xzvf ./sympy*
rm sympy*zip
cd sympy*
python setup.py install
cd ..
rm -rf sympy*
pip download --no-binary :all: --src $PREFIXPATH/venv/src nose
unzip -q ./nose*
tar xzvf ./nose*
rm nose*zip
cd nose*
python setup.py install
cd ..
rm -rf nose*
cd $MYPATH

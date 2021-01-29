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
export LDFLAGS="-L$MYPATH/libffi-3.3/$TARGET -lz"
# export LINKFORSHARED=" "
cd Python-3.9.1
export PREFIXPATH=$MYPATH/zip-dir/$TARGET
./configure --host=$CC_TARGET --target=$CC_TARGET --build=x86_64-linux  --disable-ipv6 ac_cv_file__dev_ptmx=no ac_cv_file__dev_ptc=no --with-openssl=$MYPATH/openssl-dir --without-ensurepip --prefix=$PREFIXPATH
make || exit 1
make install || exit 1
make clean
cd ..
$MYPATH/build/python/bin/pip3 install crossenv
$MYPATH/build/python/bin/python3 --version
$MYPATH/build/python/bin/python3 -m crossenv --sysroot $TOOLCHAIN/sysroot $PREFIXPATH/bin/python3 $PREFIXPATH/venv
source $PREFIXPATH/venv/bin/activate
build-pip install cython wheel cffi numpy
ls
mkdir $PREFIXPATH/venv/src
cd $PREFIXPATH/venv/src
ls
export NPY_BLAS_ORDER=
export NPY_LAPACK_ORDER=
#export CFLAGS="-I$MYPATH/zip-dir/openblas/$TARGET/include $CFLAGS"
export LDFLAGS="-lm"
#export LAPACK_SRC=$MYPATH/v3.9.0
#export BLAS=$MYPATH/zip-dir/openblas/$TARGET/lib/libblas.so
#export LAPACK=$MYPATH/zip-dir/openblas/$TARGET/lib/liblapack.so
pip download  --no-binary :all: --src $PREFIXPATH/venv/src numpy
unzip -q ./numpy*
rm numpy*zip
cd numpy*
#echo "[openblas]" >  ~/.numpy-site.cfg 
#echo "libraries = openblas" >>  ~/.numpy-site.cfg 
#echo "library_dirs = $MYPATH/zip-dir/openblas/$TARGET/lib" >>  ~/.numpy-site.cfg 
#echo "include_dirs = $MYPATH/zip-dir/openblas/$TARGET/include" >>  ~/.numpy-site.cfg 
#echo "runtime_library_dirs = $MYPATH/zip-dir/openblas/$TARGET/lib" >>  ~/.numpy-site.cfg 
#echo "search_static_first = true" >>  ~/.numpy-site.cfg 
python3 setup.py install || exit 1
cd ..
rm -rf numpy*
#echo scipystart...... 
#pip install scipy
echo jedistart......
pip install jedi
#echo scipystart...... 
#pip download --no-binary :all: --src $PREFIXPATH/venv/src scipy
#unzip -q ./scipy*
#tar xzvf ./scipy*
#rm scipy*zip
#rm scipy*gz
#cd scipy*
#python3 setup.py install || exit 1
#cd ..
#rm -rf scipy*
pip download --no-binary :all: --src $PREFIXPATH/venv/src pandas
unzip -q ./pandas*
tar xzvf ./pandas* > /dev/null
rm pandas*zip
rm pandas*gz
cd pandas*
python3 setup.py install || exit 1
cd ..
rm -rf pandas*
pip download --no-binary :all: --src $PREFIXPATH/venv/src sympy
unzip -q ./sympy*
tar xzvf ./sympy* > /dev/null
rm sympy*zip
rm sympy*gz
cd sympy*
python setup.py install || exit 1
cd ..
rm -rf sympy*
pip download --no-binary :all: --src $PREFIXPATH/venv/src nose
unzip -q ./nose*
tar xzvf ./nose* > /dev/null
rm nose*zip
rm nose*gz
cd nose*
python setup.py install || exit 1
cd ..
rm -rf nose*
cd $MYPATH
cp -a $PREFIXPATH/venv/cross/lib/python3.9/site-packages/* $PREFIXPATH/lib/python3.9/site-packages/
rm -rf $PREFIXPATH/venv

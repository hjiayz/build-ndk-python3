cp Python-3.9.1/libpython3.9.a ./$1-libpython3.9.a
cd Python-3.9.1
make clean
cd ..
cd libffi-3.3
make clean
cd ..

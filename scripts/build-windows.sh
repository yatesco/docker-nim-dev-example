#!/bin/bash
my_pwd=`pwd`
echo "Currently in $my_pwd"

mkdir -p /workdir/windows
cp -Rp * /workdir/windows/
rm -rf /workdir/windows/src/nimcache
cd /workdir/windows

wget https://zlib.net/zlib-1.2.11.tar.gz
tar -xf zlib-1.2.11.tar.gz

cd zlib-1.2.11/

# Replace the prefix with our custom one
sed -i.bak "s/PREFIX =/PREFIX = x86_64-w64-mingw32-/g" win32/Makefile.gcc

PREFIXDIR=/usr/x86_64-w64-mingw32 BINARY_PATH=$PREFIXDIR/bin INCLUDE_PATH=$PREFIXDIR/include LIBRARY_PATH=$PREFIXDIR/lib SHARED_MODE=1 make -f win32/Makefile.gcc

cd /workdir/windows

nim c --cpu:amd64 --os:windows --opt:speed --embedsrc --threads:on --checks:on  --gcc.exe:x86_64-w64-mingw32-gcc --gcc.linkerexe:x86_64-w64-mingw32-gcc -d:release --passL:"-L/workdir/windows/zlib-1.2.11/ -lzlib1" --passC:"-I/workdir/windows/zlib-1.2.11/" src/*.nim
cp src/docker_nim_dev_example.exe $my_pwd/dist/windows.exe

echo "Copied windows.exe to $my_pwd/dist"

cd $my_pwd

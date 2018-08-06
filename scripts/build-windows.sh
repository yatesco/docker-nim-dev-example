#!/bin/bash
my_pwd=`pwd`
echo "Currently in $my_pwd"

mkdir -p /workdir/windows
cp -Rp * /workdir/windows/
rm -rf /workdir/windows/src/nimcache
cd /workdir/windows

nimble c --cpu:amd64 --os:windows --opt:speed --embedsrc --threads:on --checks:on -c -d:release src/*.nim
cd src
cp /opt/Nim/lib/nimbase.h nimcache/
x86_64-w64-mingw32-gcc --save-temps nimcache/*.c -o windows.exe

cp windows.exe $my_pwd/dist/
echo "Copied windows.exe to $my_pwd/dist"

cd $my_pwd

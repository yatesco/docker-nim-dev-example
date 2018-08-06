#!/bin/bash
my_pwd=`pwd`
echo "Currently in $my_pwd"

mkdir -p /workdir/linux
cp -Rp * /workdir/linux/
rm -rf /workdir/linux/src/nimcache
cd /workdir/linux 

nimble c --cpu:amd64 --os:linux --opt:speed --embedsrc --threads:on --checks:on -c -d:release src/*.nim
cd src
cp /opt/Nim/lib/nimbase.h nimcache
gcc -o linux.exe nimcache/*.c
cp linux.exe $my_pwd/dist/
echo "Copied linux.exe to $my_pwd/dist"

cd $my_pwd

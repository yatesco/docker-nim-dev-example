#!/bin/bash
my_pwd=`pwd`
echo "Currently in $my_pwd"

mkdir -p /workdir/linux
cp -Rp * /workdir/linux/
rm -rf /workdir/linux/src/nimcache
cd /workdir/linux 

nim c --cpu:amd64 --os:linux --opt:speed --embedsrc --threads:on --checks:on -d:release src/*.nim
cp src/docker_nim_dev_example $my_pwd/dist/linux.exe
echo "Copied linux.exe to $my_pwd/dist"

cd $my_pwd

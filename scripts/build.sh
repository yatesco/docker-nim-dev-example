#!/bin/bash
mkdir /workdir
mkdir -p dist 

# download the various caches and dependencies
nimble install -d -y

/scripts/build-linux.sh
/scripts/build-windows.sh

#!/usr/bin/env bash
mkdir -p bitshares-core-build
pushd bitshares-core-build
cmake ../bitshares-core
#make
popd
DEXBot/cli.py configure

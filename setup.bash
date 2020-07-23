#!/usr/bin/env bash

# NOTE:
#	- dexbot connects to a list of hardcoded public nodes stored in its config file
#	if some of these don't respond, it could delay very long booting.
#	they can be removed from the configfile to prevent connection to them.

APT_PKGS="\
      g++ \
      autoconf \
      cmake \
      git \
      libbz2-dev \
      libcurl4-openssl-dev \
      libssl-dev \
      libncurses-dev \
      libboost-thread-dev \
      libboost-iostreams-dev \
      libboost-date-time-dev \
      libboost-system-dev \
      libboost-filesystem-dev \
      libboost-program-options-dev \
      libboost-chrono-dev \
      libboost-test-dev \
      libboost-context-dev \
      libboost-regex-dev \
      libboost-coroutine-dev \
      libtool \
      doxygen \
      ca-certificates \
      fish"
#sudo apt-get install $APT_PKGS
git submodule update --init --recursive
mkdir -p bitshares-core-build
pushd bitshares-core-build
cmake ../bitshares-core/
#make witness_node cli_wallet get_dev_key
make cli_wallet get_dev_key
popd
#bitshares-core-build/programs/witness_node/witness_node --rpc-endpoint=127.0.0.1:8090
pip3 install -r DEXBot/requirements.txt
pip3 install -r DEXBot/requirements-dev.txt
DEXBot/cli.py --configfile config/dexbot-config.yml configure

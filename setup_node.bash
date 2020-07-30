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
      fish \
      make libbz2-dev libdb++-dev libdb-dev libssl-dev openssl libreadline-dev autoconf libtool git libncurses-dev build-essential libncurses-dev doxygen libboost-all-dev autotools-dev automake"
sudo apt-get install $APT_PKGS
git submodule update --init --recursive
pushd bitshares-core
SYSTEM="$(echo $(lsb_release -ics; uname -m; git describe --tags) | tr ' ' '-')"
popd
mkdir -p bitshares-core-build
pushd bitshares-core-build
if ! [ -e CMakeCache.txt ]
then
	cmake ../bitshares-core/
fi
mkdir -p ../bin/"$SYSTEM"
make witness_node cli_wallet && cp -v programs/witness_node/witness_node programs/cli_wallet/cli_wallet ../bin/"$SYSTEM"/
popd
bitshares-core-build/programs/witness_node/witness_node --rpc-endpoint=127.0.0.1:8090

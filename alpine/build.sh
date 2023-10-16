#!/bin/sh
# MEGAcmd-ARM - Alpine Linux (>=3.17)
# (c) 2023 SuperSonic (https://github.com/supersonictw).

set -e

apk add --update --no-cache \
    c-ares \
    sqlite-libs \
    sqlite \
    pcre \
    libcurl \
    libtool \
    libuv \
    libpcrecpp \
    libsodium \
    readline \
    freeimage \
    zlib

apk add --update --no-cache --virtual .build-deps \
    autoconf \
    automake \
    c-ares-dev \
    curl \
    curl-dev \
    file \
    g++ \
    gcc \
    git \
    make \
    openssl \
    openssl-dev \
    zlib-dev \
    readline-dev \
    sqlite-dev \
    pcre-dev \
    libc-dev \
    libffi-dev \
    libsodium \
    libsodium-dev \
    libuv-dev \
    freeimage-dev

apk add --repository https://dl-cdn.alpinelinux.org/alpine/edge/community --update --no-cache \
    crypto++ \
    crypto++-dev

git clone --recursive https://github.com/meganz/MEGAcmd.git /tmp/MEGAcmd
cd /tmp/MEGAcmd

sh autogen.sh
./configure \
    --without-freeimage \
    --disable-examples \
    --host=armv6-alpine-linux-musleabihf
make -j $(nproc)

# clean:
# apk del .build-deps crypto++-dev

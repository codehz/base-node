#!/bin/bash -ex
npm i --unsafe-perm
npm prune
mkdir -p rootfs
/packager.sh -d /usr/bin/node rootfs
for var in "$@"; do
  /packager.sh -d "$var" rootfs
done
#!/bin/sh
export RKE2_VERSION=v1.21.8%2Brke2r2
curl -OLs https://github.com/rancher/rke2/releases/download/$RKE2_VERSION/rke2-images-core.linux-amd64.tar.zst
curl -OLs  https://github.com/rancher/rke2/releases/download/$RKE2_VERSION/rke2-images-cilium.linux-amd64.tar.zst
curl -OLs https://github.com/rancher/rke2/releases/download/$RKE2_VERSION/sha256sum-amd64.txt
curl -OLs https://github.com/rancher/rke2/releases/download/$RKE2_VERSION/rke2.linux-amd64.tar.gz

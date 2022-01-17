#!/bin/bash
set -euxo pipefail

# Images from https://github.com/rancher/rke2/releases/ downloaded to airgap

echo Copy images from /vagrant/airgap/ to /var/lib/rancher/rke2/agent/images/

mkdir -p /var/lib/rancher/rke2/agent/images/
cp /vagrant/airgap/*.tar.zst /var/lib/rancher/rke2/agent/images/

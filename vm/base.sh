#!/bin/bash
set -euxo pipefail

# prevent apt-get et al from asking questions.
# NB even with this, you'll still get some warnings that you can ignore:
#     dpkg-preconfigure: unable to re-open stdin: No such file or directory
export DEBIAN_FRONTEND=noninteractive

# # make sure the system does not uses swap (a kubernetes requirement).
# # NB see https://kubernetes.io/docs/tasks/tools/install-kubeadm/#before-you-begin
# swapoff -a
# sed -i -E 's,^([^#]+\sswap\s.+),#\1,' /etc/fstab

# show mac/ip addresses and the machine uuid to troubleshoot they are unique within the cluster.
ip addr
cat /sys/class/dmi/id/product_uuid

# https://wiki.debian.org/ReduceDebian

# update the package cache.
apt-get update

APT_PACKAGES=""

# Install jq
APT_PACKAGES+=" jq"

# Install curl
APT_PACKAGES+=" curl"

# Install the bash completion
APT_PACKAGES+=" bash-completion"

# Install the VIM
APT_PACKAGES+=" vim-tiny"

# Install useful tools
APT_PACKAGES+=" tcpdump traceroute iptables"

# install packages
apt-get install -y --no-install-recommends $APT_PACKAGES

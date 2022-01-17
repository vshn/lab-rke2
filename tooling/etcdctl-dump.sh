#!/bin/bash
set -euxo pipefail

# list etcd members.
etcdctl --write-out table member list

# show the endpoint status.
etcdctl --write-out table endpoint status

# About

This is a [rke2](https://github.com/rancher/rke2) Kubernetes Cluster Lab wrapped in a Vagrant environment.

A friendly fork of [rgl/rke2-vagrant](https://github.com/rgl/rke2-vagrant). Thanks for all the prework!

# Usage

Install the required vagrant plugins:

```bash
vagrant plugin install vagrant-hosts vagrant-libvirt
```

Nfs-utils:
```bash
sudo pacman -S nfs-utils
```

Launch the environment:

```bash
time vagrant up --no-destroy-on-error --no-tty [--provider=libvirt]
```

**NB** The controlplane VMs (e.g. `cp1`) are [tainted](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) to prevent them from executing non control-plane workloads. That kind of workload is executed in the worker nodes (e.g. `w1`).

## Kubernetes API

Access the Kubernetes API at:

    https://vip.rke2.lab:6443

**NB** You must use the client certificate that is inside the `tmp/admin.conf`,
`tmp/*.pem`, or `/etc/rancher/rke2/rke2.yaml` (inside the `cp1` machine)
file.

Access the Kubernetes API using the client certificate with httpie:

```bash
http \
    --verify tmp/default-ca-crt.pem \
    --cert tmp/default-crt.pem \
    --cert-key tmp/default-key.pem \
    https://vip.rke2.lab:6443
```

Or with curl:

```bash
curl \
    --cacert tmp/default-ca-crt.pem \
    --cert tmp/default-crt.pem \
    --key tmp/default-key.pem \
    https://vip.rke2.lab:6443
```

## K9s Dashboard (TODO)

The [K9s](https://github.com/derailed/k9s) console UI dashboard is also
installed in the controlplane node. You can access it by running:

```bash
vagrant ssh cp1
sudo su -l
k9s
```

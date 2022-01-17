# to make sure the VM are created in order, we
# have to force a --no-parallel execution.
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

require 'ipaddr'

# see https://update.rke2.io/v1-release/channels
# see https://github.com/rancher/rke2/releases
rke2_channel = 'v1.21'
rke2_version = 'v1.21.8+rke2r2'
# see https://github.com/etcd-io/etcd/releases
# NB make sure you use the same version as rke2.
etcdctl_version = 'v3.4.16'
# see https://github.com/derailed/k9s/releases
k9s_version = 'v0.25.18'
# see https://github.com/kubernetes-sigs/krew/releases
krew_version = 'v0.4.2'

number_of_controlplane_vm = 1
number_of_worker_vm       = 0

controlplane_vip         = '10.11.0.5'
first_controlplane_vm_ip = '10.11.0.6'
worker_vip               = '10.11.0.10'
first_worker_vm_ip       = '10.11.0.11'

name_prefix_controlplane_vm = 'cp'
name_prefix_worker_vm       = 'w'

controlplane_vm_ip_address = IPAddr.new first_controlplane_vm_ip
worker_vm_ip_address       = IPAddr.new first_worker_vm_ip

cluster_domain   = 'rke2.lab'
cluster_vip_name = "vip.#{cluster_domain}"
cluster_k8s_api  = "https://#{cluster_vip_name}:6443"
rke2_server_url  = "https://#{cluster_vip_name}:9345"

application_domain = 'apps.rke2.lab'

Vagrant.configure(2) do |config|
  config.vm.box = 'generic/ubuntu2004'

  config.vm.provider 'libvirt' do |lv, config|
    lv.cpus = 2
    lv.cpu_mode = 'host-passthrough'
    lv.nested = true
    lv.keymap = 'pt'
    config.vm.synced_folder '.', '/vagrant', type: 'nfs', nfs_version: '4.2', nfs_udp: false
  end

  ### CONTROLPLANE VMs
  (1..number_of_controlplane_vm).each do |n|
    name = "#{name_prefix_controlplane_vm}#{n}"
    fqdn = "#{name}.#{cluster_domain}"
    ip_address = controlplane_vm_ip_address.to_s; controlplane_vm_ip_address = controlplane_vm_ip_address.succ

    config.vm.define name do |config|
      config.vm.provider 'libvirt' do |lv, config|
        lv.memory = 1024
      end
      config.vm.hostname = fqdn
      config.vm.network :private_network, ip: ip_address, libvirt__forward_mode: 'none', libvirt__dhcp_enabled: false
      config.vm.provision 'hosts' do |hosts|
        hosts.autoconfigure = true
        hosts.sync_hosts = true
        hosts.add_localhost_hostnames = false
        hosts.add_host controlplane_vip, [cluster_vip_name]
      end
      config.vm.provision 'shell', path: 'vm/base.sh'
      config.vm.provision 'shell', path: 'vm/controlplane.sh'
      config.vm.provision 'shell', path: 'rke2/server-images.sh'
      config.vm.provision 'shell', path: 'rke2/server.sh', args: [
        n == 1 ? "cluster-init" : "cluster-join",
        rke2_channel,
        rke2_version,
        ip_address,
        krew_version
      ]
      config.vm.provision 'shell', path: 'net/kube-vip.sh', args: [
        controlplane_vip,
        'eth1',
      ]
      #TODO:
      #config.vm.provision 'shell', path: 'tooling/etcdctl.sh', args: [etcdctl_version]
      #config.vm.provision 'shell', path: 'provision-k9s.sh', args: [k9s_version]
      if n == 1
        config.vm.provision 'shell', path: 'k8s/example-app.sh'
      end
    end
  end

  ### WORKER VMs
  (1..number_of_worker_vm).each do |n|
    name = "#{name_prefix_worker_vm}#{n}"
    fqdn = "#{name}.#{cluster_domain}"
    ip_address = worker_vm_ip_address.to_s; worker_vm_ip_address = worker_vm_ip_address.succ

    config.vm.define name do |config|
      config.vm.provider 'libvirt' do |lv, config|
        lv.memory = 2*1024
      end
      config.vm.hostname = fqdn
      config.vm.network :private_network, ip: ip_address, libvirt__forward_mode: 'none', libvirt__dhcp_enabled: false
      config.vm.provision 'hosts' do |hosts|
        hosts.autoconfigure = true
        hosts.sync_hosts = true
        hosts.add_localhost_hostnames = false
        hosts.add_host first_controlplane_vm_ip, [cluster_vip]
      end
      config.vm.provision 'shell', path: 'vm/base.sh'
      config.vm.provision 'shell', path: 'vm/worker.sh'
      config.vm.provision 'shell', path: 'rke2/agent.sh', args: [
        rke2_channel,
        rke2_version,
        rke2_server_url,
        ip_address
      ]
    end
  end
end

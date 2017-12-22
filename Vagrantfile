
Vagrant.require_version ">= 1.7.0"

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox"
  config.vm.box = "bento/ubuntu-16.04"

  master = 1
  node = 2
  private_count = 10
  (1..(master + node)).each do |mid|
    name = (mid <= node) ? "node" : "master"
    id   = (mid <= node) ? mid : (mid - node)
    config.vm.define "#{name}#{id}" do |n|
      n.vm.hostname = "#{name}#{id}"
      ip_addr = "192.16.35.#{private_count}"
      n.vm.network :private_network, ip: "#{ip_addr}",  auto_config: true
      n.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
      end
      private_count += 1
    end
  end
  config.vm.provision :shell, path: "./hacks/deps.sh"
end

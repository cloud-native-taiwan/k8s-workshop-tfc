# Kubernetes Workshop
This repository is based on Kubernetes workshop. Show a simple Kubernetes cluster and resources. This directory contains a number of examples of how to run real applications with Kubernetes to help you understand how to work.

Slides:
- [帶著藍船舵(Kubernetes)初航雲海吧!](https://goo.gl/ZeWYfz)

**Requirements**

You will need a environment with at least `8GB RAM` and `30GB free disk space` available:
* Virtual Machine tool(choose one)
  * VirtualBox >= 5.1.0.
  * Hyper-v.
  * Libvirt KVM or QEMU.
* Vagrant >= 1.7.0.
* bash.
* Git tool.

**Install version**

The workshop will install as the following version:
* Kubernetes Version: 1.9.0
* Etcd: v3.2.9
* Calico: v2.6.2
* Docker: v17.10.0-ce

## Deploy cluster
In this section we need to setup a Kubernetes cluster on VM.

### Mac OS X, Linux and Windows(VirtualBox)
To create VM without auto deploy:
```sh
$ git clone https://github.com/kairen/kube-ansible.git
$ cd kube-ansible
$ ./tools/setup -i eth1 --combine-master 0 --combine-etcd 0 --deploy false
$ vagrant ssh master1
```

To install Ansible tool:
```sh
$ sudo apt-get install -y software-properties-common git
$ sudo apt-add-repository -y ppa:ansible/ansible
$ sudo apt-get update && sudo apt-get install -y ansible
```

To deploy cluster and addons:
```sh
$ cd /vagrant
$ ansible-playbook cluster.yml

# Modify `group_vars/all.yml` kube_dashboard and ingress variable to true.
$ ansible-playbook addons.yml
$ kubectl -n kube-system get po
NAME                                       READY     STATUS    RESTARTS   AGE
calico-node-bgdtj                          2/2       Running   0          3m
calico-node-frq98                          2/2       Running   0          3m
calico-node-jkpjl                          2/2       Running   0          3m
calico-policy-controller-fb675cfbc-9r98v   1/1       Running   0          3m
haproxy-master1                            1/1       Running   0          1m
keepalived-master1                         1/1       Running   0          1m
kube-apiserver-master1                     1/1       Running   0          1m
kube-controller-manager-master1            1/1       Running   0          1m
kube-dns-74bf5c4b94-48z44                  3/3       Running   0          3m
kube-proxy-5b7qt                           1/1       Running   0          3m
kube-proxy-9rd8m                           1/1       Running   0          3m
kube-proxy-vnkpm                           1/1       Running   0          3m
kube-scheduler-master1                     1/1       Running   0          1m
```

### Windows 10(Hyper-v)
To create VM without auto deploy:
```sh
$ git clone https://github.com/kairen/kube-ansible.git
$ cd kube-ansible
$ ./tools/setup -p hyperv -i eth0 --combine-master 0 --combine-etcd 0
$ vagrant ssh master1
```
> P.S. Hyper-v [Limited Networking](https://www.vagrantup.com/docs/hyperv/limitations.html#limited-networking).

To install Ansible tool:
```sh
$ sudo apt-get install -y software-properties-common git
$ sudo apt-add-repository -y ppa:ansible/ansible
$ sudo apt-get update && sudo apt-get install -y ansible
```

In `master1` node, edit the `/etc/hosts` file and change IPs :
```sh
127.0.0.1       localhost

172.23.109.237 master1
172.23.109.230 node1
172.23.109.229 node2

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

In `master1` node, edit the `/vagrant/inventory` file and change IPs:
```sh
[etcds]
172.23.109.237 ansible_user=vagrant ansible_password=vagrant

[masters]
172.23.109.237 ansible_user=vagrant ansible_password=vagrant

[nodes]
172.23.109.230  ansible_user=vagrant ansible_password=vagrant
172.23.109.229 ansible_user=vagrant ansible_password=vagrant

[kube-cluster:children]
masters
nodes

[kube-addon:children]
masters
```

In `master1` node, configure the `/vagrant/group_vars/all.yml` file and change these vars:
```sh
lb_vip_address: 172.23.109.237
keepalived: false

kube_dashboard: true
ingress: true
```
> P.S. Only change these vars. Other variables using by default.

To deploy cluster and addons:
```sh
$ cd /vagrant
$ ansible nodes -m copy -a "src=/etc/hosts dest=/etc/" -b
$ ansible-playbook cluster.yml
$ ansible-playbook addons.yml
```

![Imgur](https://i.imgur.com/qXhsAem.png)

## Run examples
In `master1` node to get workshop examples from [k8s-workshop](https://github.com/kairen/k8s-workshop.git):
```sh
$ git clone https://github.com/kairen/k8s-workshop.git
$ cd k8s-workshop/resources
```

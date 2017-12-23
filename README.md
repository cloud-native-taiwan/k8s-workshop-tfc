# TFC Workshop
This repository is based on TFC Workshop. Show a simple Kubernetes cluster and resources. This directory contains a number of examples of how to run real applications with Kubernetes to help you understand how to work.

**Requirements**:

You will need Mac OSX or Linux with at least `8GB RAM` and `30GB free disk space` available:
* VirtualBox: >= 5.0.0.
* Vagrant: >= 1.7.0.

**Install version**:
* Kubernetes Version: 1.9.0
* Etcd: v3.2.9
* Calico: v2.6.2
* Docker: v17.10.0-ce

To build cluster:
```sh
$ git clone https://github.com/kairen/tfc-workshop.git
$ vagrant up
$ vagrant ssh master1
$ sudo su -
$ cd /vagrant/ansible
$ ansible-playbook cluster.yml
$ ansible-playbook addons.yml
```

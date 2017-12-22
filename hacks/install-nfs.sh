#!/bin/bash
#
# Program: Install nfs
# History: 2017/12/23 Kyle.b Release

set -xe

sudo apt-get update && sudo apt-get install -y nfs-server
mkdir -p /exports

cat <<EOF > /etc/exports
/exports *(rw,fsid=0,root_squash,no_subtree_check,insecure)
EOF

sudo systemctl restart nfs-server

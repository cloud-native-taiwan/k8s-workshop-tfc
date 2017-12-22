#!/bin/bash
#
# Program: Open API
# History: 2017/12/23 Kyle.b Release

set -xu

cat <<EOF | kubectl create -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: open-api-role
  namespace: ""
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: system:anonymous
EOF

kubectl -n kube-system create sa dashboard
kubectl create clusterrolebinding dashboard --clusterrole cluster-admin --serviceaccount=kube-system:dashboard

echo -n "
Get token: kubectl -n kube-system get sa dashboard -o yaml
Access url: https://192.16.35.9:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
"

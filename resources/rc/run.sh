#!/bin/bash

kubectl run nginx --image nginx --port 80 --generator=run/v1
kubectl expose rc nginx --type NodePort --target-port 80
kubectl scale rc nginx --replicas=2
pods=$(kubectl get pods --selector=app=nginx --output=jsonpath={.items..metadata.name})

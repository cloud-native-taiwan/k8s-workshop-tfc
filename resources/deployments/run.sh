#!/bin/bash

kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1
kubectl rollout history deployment/nginx-deployment
kubectl rollout undo deployment/nginx-deployment

#!/bin/bash

kubectl -f crd.yml -f workshop.yml
kubectl get workshop

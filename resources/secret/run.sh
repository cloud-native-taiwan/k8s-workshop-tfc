#!/bin/bash

kubectl create secret generic db-user-pass --from-file=./username.txt --from-file=./password.txt

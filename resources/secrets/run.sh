#!/bin/bash

echo -n "kairen" > username.txt
echo -n "p@ssw0rd" > password.txt

kubectl create secret generic db-user-pass --from-file=./username.txt --from-file=./password.txt

#!/bin/bash
date
set -e

echo "check all nodes in kubernetes cluster"

kubectl get nodes -o wide

echo "Drain Worker-1 Node & Worker-2 Node"
kubectl drain worker01 --ignore-daemonsets --delete-emptydir-data \
&& kubectl drain worker02 --ignore-daemonsets --delete-emptydir-data

echo "check all nodes in kubernetes cluster"

kubectl get nodes -o wide

#!/bin/bash


echo "Check Kubernetes All Nodes Status"
kubectl get nodes -o wide



echo "Check Kubernetes All Pods, Service & Namespace Status"

kubectl get pod,svc,namespace -A -o wide


echo "Uncordon Master-Node Controller 1st" 
kubectl uncordon master-node


echo "Check Kubernetes All Nodes Status"
kubectl get nodes -o wide

echo "Check All Pods in Calico-System Namespace"

kubectl get pods -n calico-system

echo "Check All pods Label Named as calico-node"

kubectl get pods -l k8s-app=calico-node -A

echo "Watch Calico TigerasStatus"

watch kubectl get tigerastatus

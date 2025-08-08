#!/bin/bash


echo "Uncordong K8-Worker-01 Node"

kubectl uncordon worker01

echo "Uncordong K8-Worker-02 Node"

kubectl uncordon worker02


echo "Check All Node status in Kubernetes Cluster"

kubectl get nodes


echo "Check all pods,svc,namespace in Kubernetes Cluster"

kubectl get pods,svc,namespace -A -o wide


echo "Check pods in all namespaces, focus on not Ready or not Running in Kubernetes Cluster"

kubectl get pods --all-namespaces

echo "Check control plane pods (on master node)"

kubectl -n kube-system get pods

echo "Check for any pods in CrashLoopBackOff or Error states in Kubernetes Cluster"

kubectl get pods --all-namespaces | grep -E "CrashLoopBackOff|Error|Pending| Terminating"


echo "Verify core components health"
kubectl get componentstatuses


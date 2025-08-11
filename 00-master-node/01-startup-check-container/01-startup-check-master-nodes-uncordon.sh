##01-startup-check-master-nodes-uncordon.sh
#!/bin/bash
date
set -e

echo "This is Container Master-Nodes Kubernetes Cluster check up bash script!"
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

echo "Watch Calico Pods, Services & TigerasStatus in Calico-System Namespace"
#watch kubectl get tigerastatus
watch kubectl get pods,svc,tigerastatus -n calico-system


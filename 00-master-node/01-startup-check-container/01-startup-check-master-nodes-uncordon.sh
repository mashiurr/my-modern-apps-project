##01-startup-check-master-nodes-uncordon.sh
#!/bin/bash
date
set -e

echo "This is Container Master-Nodes Kubernetes Cluster check up bash script!"

# Pause before next step
read -p "Press [Enter] to continue to [STEP 1] Check Kubernetes All Nodes Status"
echo "Check Kubernetes All Nodes Status"
kubectl get nodes -o wide

echo "Check Kubernetes All Pods, Service & Namespace Status"
kubectl get pod,svc,namespace -A -o wide

# Pause before next step
read -p "Press [Enter] to continue to [STEP 2] Uncordon Master-Node Controller 1st" 

echo "Uncordon Master-Node Controller 1st" 
kubectl uncordon master-node

echo "Check Kubernetes All Nodes Status"
kubectl get nodes -o wide

echo "Check All Pods in Calico-System Namespace"
kubectl get pods -n calico-system

echo "Check All pods Label Named as calico-node"
kubectl get pods -l k8s-app=calico-node -A

# Pause before next step
read -p "Press [Enter] to continue to [STEP 3] Watch Calico Pods, Services & TigerasStatus in Calico-System Namespace"
echo "Watch Calico Pods, Services & TigerasStatus in Calico-System Namespace"
#watch kubectl get tigerastatus
watch kubectl get pods,svc,tigerastatus -n calico-system


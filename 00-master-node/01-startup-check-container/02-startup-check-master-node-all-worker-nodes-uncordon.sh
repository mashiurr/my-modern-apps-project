#02-startup-check-master-node-all-worker-nodes-uncordon script
#!/bin/bash
echo "This Start-up Check for Master Node to Uncordon all the Worker Nodes"
date
set -e

# Pause before next step
read -p "Press [Enter] to continue to [STEP 1] Uncordong K8-Worker-01 & K8-Worker-02 Nodes"
echo "Uncordong K8-Worker-01 Node"
kubectl uncordon worker01

echo "Uncordong K8-Worker-02 Node"
kubectl uncordon worker02

# Pause before next step
read -p "Press [Enter] to continue to [STEP 2] Check All Node status in Kubernetes Cluster"
echo "Check All Node status in Kubernetes Cluster"
kubectl get nodes -o wide

echo "Check all pods,svc,namespace in Kubernetes Cluster"
kubectl get namespace,pods,svc,ingress,secret -A -o wide

echo "Check pods in all namespaces, focus on not Ready or not Running in Kubernetes Cluster"
kubectl get pods --all-namespaces

echo "Check control plane pods (on master node)"
kubectl -n kube-system get pods

echo "Verify core components health"
kubectl get componentstatuses

#echo "Check for any pods in CrashLoopBackOff or Error states in Kubernetes Cluster"
#kubectl get pods --all-namespaces | grep -E "CrashLoopBackOff|Error|Pending| Terminating"
# Pause before next step
read -p "Press [Enter] to continue to [STEP 3] Verify All the pods, Services, namespaces are running in Watch mode"

echo "Verify All the pods, Services, namespaces are running in Watch mode"
watch kubectl get nodes,namespace,pods,svc,ingress,secret -A


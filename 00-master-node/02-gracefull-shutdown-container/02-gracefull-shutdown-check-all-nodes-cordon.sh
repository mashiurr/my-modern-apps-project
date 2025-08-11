  GNU nano 6.2                                                        00-gracefull-shutdown-container/01-drain-masternode.sh                                                                  
#!/bin/bash
date
set -e

echo "check all nodes in kubernets cluster"
kubectl get nodes -o wide

echo "check all pods, services & namespace in kubernets cluster"
kubectl get pods,svc,namespace -A -o wide

echo "Make Sure All Workers & master controller nodes are “cordon”" 

kubectl cordon worker01

kubectl cordon worker02

kubectl cordon master-node

## k8s-kubeadm cluster initiation for Master Node
#!/bin/bash
set -e


# Kubeadm Init cluster with Pod CIDR with calico

echo "[STEP 1] Init cluster with Pod CIDR 192.168.0.0/16 at master-node" 
cd /

# Pause before next step
read -p "Press [Enter] to continue to STEP 1:  Init cluster with Pod CIDR 192.168.0.0/16 at master-node..."
sudo kubeadm init --control-plane-endpoint=master-node --pod-network-cidr=192.168.0.0/16 --upload-certs

echo "[Completed] k8s-kubeadm cluster initiation for Master Node " 

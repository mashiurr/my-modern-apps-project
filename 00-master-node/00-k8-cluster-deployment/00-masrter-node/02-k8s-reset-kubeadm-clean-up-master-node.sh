## k8s-kubeadm Reste - Steps to reset kubeadm and clean up the node
#!/bin/bash
set -e

echo "[STEP 1] Reset kubeadm]"

sudo kubeadm reset -f

echo "Removed cluster state and configurations created by kubeadm init or kubeadm join”

echo "[STEP 2] Remove leftover CNI and network interfaces”
sudo rm -rf /etc/cni/net.d

echo "Removed CNI and network interfaces”


echo "[STEP 3] Remove Kubernetes state directories:”
sudo rm -rf $HOME/.kube
sudo rm -rf /var/lib/kubelet/*
sudo rm -rf /etc/kubernetes

echo "Delete Completed Kubernetes state directories.”


echo "[STEP 4] Restart container runtime (containerd)”

sudo systemctl restart containerd

echo "[STEP 5] Done! Node is Cleanedup Kubernetes v1.33. Please reboot now  [sudo reboot now]"

kubeadm version


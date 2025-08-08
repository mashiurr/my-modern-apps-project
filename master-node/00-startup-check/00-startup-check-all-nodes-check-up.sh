#!/bin/bash

# Example Bash script
echo "This is Container All-Nodes check up bash script!"
date


echo "All-Nodes check up: For “containerd” Installed Nodes:"

sudo systemctl enable containerd && sudo systemctl start containerd &&  sudo systemctl status containerd

echo "All-Nodes check up: For Kubernetes “kubeadm” Installed Nodes:"

kubeadm version && sudo cat /etc/modules-load.d/containerd.conf && sudo cat /etc/sysctl.d/kubernetes.conf && sudo cat /etc/hosts

echo "For Master-Node only “containerd” based: Check Kubelet, containerd-daemon & Kubeadm Configuration"

sudo cat /etc/default/kubelet && sudo cat /etc/containerd/daemon.json && sudo cat /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf

echo "Restart systemctl daemon, Conatinerd & Kublet"

sudo systemctl daemon-reload && sudo systemctl restart containerd && sudo systemctl daemon-reload && sudo systemctl restart kubelet

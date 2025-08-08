#!/bin/bash

# Example Bash script
echo "This is Container All-Nodes check up bash script!"
date


echo "All-Nodes check up: For “containerd” Installed Nodes:"

sudo systemctl enable containerd && sudo systemctl start containerd &&  sudo systemctl status containerd



echo "All-Nodes check up: For Kubernetes “kubeadm” Installed Nodes:"

kubeadm version && sudo cat /etc/modules-load.d/containerd.conf && sudo cat /etc/sysctl.d/kubernetes.conf && sudo cat /etc/hosts


echo "Check Apparmor status"

sudo systemctl status apparmor

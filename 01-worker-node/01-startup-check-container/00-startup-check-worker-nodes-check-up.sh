#00-startup-check-all-nodes-check-up script
#!/bin/bash
echo "This is Container Worker-Nodes check up bash script!"
date
set -e

echo "Worker-Nodes check up: For “containerd” Installed Nodes:"

sudo systemctl enable containerd && sudo systemctl start containerd &&  sudo systemctl status containerd

echo "Worker-Nodes check up: For Kubernetes “kubeadm” Installed Nodes:"

#kubeadm version && sudo cat /etc/modules-load.d/containerd.conf && sudo cat /etc/sysctl.d/kubernetes.conf && sudo cat /etc/hosts
kubeadm version  && sudo cat /etc/sysctl.d/k8s.conf && sudo cat /etc/hosts && sudo sysctl --system

#echo "Check Apparmor status"
#sudo systemctl status apparmor

echo "Restart systemctl daemon, Conatinerd & Kublet"
sudo systemctl daemon-reload && sudo systemctl restart containerd && sudo systemctl daemon-reload && sudo systemctl restart kubelet

echo "[COMPLETED !!! Star-up Check-Up Process & deamon Restart Process completed for Containerd & kubernetes]"

#00-startup-check-master-nodes-check-up script
#!/bin/bash
echo "This is Container Master-Nodes check up bash script!"
date
set -e

echo "Master-Nodes check up: For “containerd” Installed Nodes:"
sudo systemctl enable containerd && sudo systemctl start containerd &&  sudo systemctl status containerd

# Pause before next step
read -p "Press [Enter] to continue to Master-Nodes check up: For Kubernetes “kubeadm” Installed Nodes:..."

echo "Master-Nodes check up: For Kubernetes “kubeadm” Installed Nodes:"
#kubeadm version && sudo cat /etc/modules-load.d/containerd.conf && sudo cat /etc/sysctl.d/kubernetes.conf && sudo cat /etc/hosts

kubeadm version  && sudo cat /etc/sysctl.d/k8s.conf && sudo cat /etc/hosts && sudo sysctl --system

#echo "For Master-Node only “containerd” based: Check Kubelet, containerd-daemon & Kubeadm Configuration"
#sudo cat /etc/default/kubelet && sudo cat /etc/containerd/daemon.json && sudo cat /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf

# Pause before next step
read -p "Press [Enter] to continue to Master-Nodes check up: Restart systemctl daemon, Conatinerd & Kublet..."

echo "Restart systemctl daemon, Conatinerd & Kublet"

sudo systemctl daemon-reload && sudo systemctl restart containerd && sudo systemctl daemon-reload && sudo systemctl restart kubelet

echo "[COMPLETED !!! Star-up Check-Up Process & deamon Restart Process completed for Containerd & kubernetes]"

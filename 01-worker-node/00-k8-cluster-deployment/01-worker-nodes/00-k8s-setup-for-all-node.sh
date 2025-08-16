## k8s-setup for All Node
#!/bin/bash
set -e

echo "[STEP 1] Update system"
sudo apt update && sudo apt upgrade -y

echo "[STEP 1] Update system"
sudo apt update && sudo apt upgrade -y

echo "[STEP 2] Disable swap"
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "[STEP 3] Load kernel modules"
sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

echo "[STEP 4] Set sysctl params for Kubernetes"
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

echo "[STEP 5] Install containerd"
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update && sudo apt install -y containerd.io
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

echo "[STEP 6] Install Kubernetes v1.33 from official repo"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /" | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "[STEP 7] Done! Kubernetes v1.33. Installed with kubelet kubeadm kubectl"

echo "[STEP 8] Host Entry All Nodes (master & worker) for Kubernetes Cluster Nodes”

sudo tee -a /etc/hosts > /dev/null <<EOL
10.1.1.4 master-node
10.1.1.5 worker01
10.1.1.6 worker02
EOL

sudo cat /etc/hosts
sudo sysctl --system

echo "[STEP 8] Done! Node is ready for Kubernetes v1.33. Please reboot now with by type [sudo reboot now] and press Enter"
cd /
kubeadm version

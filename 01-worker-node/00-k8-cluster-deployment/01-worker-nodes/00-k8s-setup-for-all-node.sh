## k8s-setup for All Node
#!/bin/bash
date
set -e

echo "[STEP 1] Update system"
sudo apt update && sudo apt upgrade -y

# Pause before next step
read -p "Press [Enter] to continue to STEP 2: Disable swap..."

echo "[STEP 2] Disable swap"
sudo swapoff -a

sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Pause before next step
read -p "Press [Enter] to continue to STEP 3 Load kernel modules..."

echo "[STEP 3] Load kernel modules"
sudo modprobe overlay

sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# Pause before next step
read -p "Press [Enter] to continue to STEP 4: Set sysctl params for Kubernetes..."

echo "[STEP 4] Set sysctl params for Kubernetes"

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo cat /etc/sysctl.d/k8s.conf

sudo sysctl --system

# Pause before next step
read -p "Press [Enter] to continue to STEP 5: Install containerd..."

echo "[STEP 5] Install containerd"

#sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
sudo apt update && sudo apt install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Pause before next step
read -p "Press [Enter] to continue to STEP 5.1: Update APT index and install containerd.io"..."

echo "Step 5.1 Update APT index and install containerd.io"

sudo apt update && sudo apt install -y containerd.io && containerd --version

echo "Step 5.2 Enable and start the containerd service"

sudo systemctl enable --now containerd && sudo systemctl status containerd

# Pause before next step
read -p "Press [Enter] to continue to STEP 5.3: (Optional but recommended) Generate and tweak default config—for example, enabling SystemdCgroup for Kubernetes compatibility..."

echo "Step 5.3 (Optional but recommended) Generate and tweak default config—for example, enabling SystemdCgroup for Kubernetes compatibility:.."

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml && sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml 
sudo systemctl restart containerd

sudo systemctl restart containerd && sudo systemctl enable containerd && sudo systemctl status containerd


# Pause before next step
read -p "Press [Enter] to continue to STEP 6: Install kubernetes 1.33 in ubuntu 22.04 LTS from official apt repositoryo..."

echo "[STEP 6] Install kubernetes 1.33 in ubuntu 22.04 LTS from official apt repository"

sudo swapoff -a && sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Set Up the Kubernetes v1.33 APT Repository
# Create directory for keyrings if it doesn't exist
sudo mkdir -p /etc/apt/keyrings && sudo mkdir -p -m 755 /etc/apt/keyrings

sudo apt update && sudo apt-get install -y apt-transport-https ca-certificates curl gpg lsb-release

# Add the GPG key for v1.33
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the v1.33 repository
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

#Install Kubernetes Components (v1.33)
sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubectl && sudo apt-mark hold kubelet kubeadm kubectl && kubeadm version


# Pause before next step
read -p "Press [Enter] to continue to STEP 7: Done! Kubernetes v1.33. Installed with kubelet kubeadm kubectl"..."

echo "[STEP 7] Done! Kubernetes v1.33. Installed with kubelet kubeadm kubectl"

echo "[STEP 8] Host Entry All Nodes (master & worker) for Kubernetes Cluster Nodes”

sudo sh -c "echo '10.1.1.4 master-node' >> /etc/hosts"
sudo sh -c "echo '10.1.1.5 worker01' >> /etc/hosts"
sudo sh -c "echo '10.1.1.6 worker02' >> /etc/hosts" 

sudo cat /etc/hosts

sudo sysctl --system

echo "[STEP 8] Done! Node is ready for Kubernetes v1.33. Please reboot now with by type [sudo reboot now] and press enter"

cd /

kubeadm version

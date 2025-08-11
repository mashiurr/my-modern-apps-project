## k8s-Configure kubectl for Master Node
#!/bin/bash
set -e

# k8s-Configure kubectl for Master Node
echo "[STEP 1] k8s-Configure kubectl for master-node" 

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

read -p "Press Enter to finis" input

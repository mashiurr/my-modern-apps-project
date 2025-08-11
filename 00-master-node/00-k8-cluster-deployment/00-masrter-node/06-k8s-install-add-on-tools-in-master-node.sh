## k8s- Install Add-On Tools in Master Node
#!/bin/bash
set -e

cd /
mkdir 08-install-add-on
cd 08-install-add-on

echo "[STEP 1] Installing Helm" 

mkdir helm
cd helm

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 
chmod 700 get_helm.sh
./get_helm.sh

cd..

echo "[STEP 2] Installing k9s" 

mkdir k9s
cd k9s
wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_linux_amd64.deb 

sudo apt install ./k9s_linux_amd64.deb
cd ..


echo "[STEP 2] Install calicoctl & kubectl-calico" 
cd /usr/local/bin/

curl -L https://github.com/projectcalico/calico/releases/download/v3.30.1/calicoctl-linux-amd64 -o calicoctl
chmod +x ./calicoctl

curl -L https://github.com/projectcalico/calico/releases/download/v3.30.1/calicoctl-linux-amd64 -o kubectl-calico
chmod +x kubectl-calico

cd/
kubectl calico -h
calicoctl version --client

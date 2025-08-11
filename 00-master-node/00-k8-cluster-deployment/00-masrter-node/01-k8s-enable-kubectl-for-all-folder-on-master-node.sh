##Enable Kubectl for All -Folder & Autocompletion for kubectl on master-node
#!/bin/bash
set -e
echo "[STEP 1]Enable Kubectl for All -Folder &  Autocompletion for kubectl on master-node”

cd /
sudo apt install -y bash-completion
cd /
echo "alias k='kubectl'" >> ~/.bashrc
echo 'export KUBECONFIG="/.kube/config"' >>~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc
source ~/.bashrc
echo $KUBECONFIG
sudo cat ~/.bashrc
echo "[Completed]”

## k8s- Install Calico Pod Network Add-On in Master Node
#!/bin/bash
set -e

cd /
# k8s-Configure kubectl for Master Node
echo "[STEP 1] Create 07-calico Folder" 

mkdir 07-calico
cd 07-calico

echo "#Calico v3.30.2 : Install Calico networking and network policy for on-premises deployments”
#Ref: https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises 

# Pause before next step
read -p "Press [Enter] to continue to [STEP 1] Download the Calico Tigera Operator and Calco Custom Resource definitions for Calico v3.30.2:..."

echo "[STEP 1] Download the Calico Tigera Operator and Calco Custom Resource definitions for Calico v3.30.2:”

curl -o 00-calico-operator-crds.yaml https://raw.githubusercontent.com/projectcalico/calico/v3.30.2/manifests/operator-crds.yaml -O

curl -o 01-calico-tigera-operator.yaml https://raw.githubusercontent.com/projectcalico/calico/v3.30.2/manifests/tigera-operator.yaml -O

curl -o 02-calico-custom-resources.yaml https://raw.githubusercontent.com/projectcalico/calico/v3.30.2/manifests/custom-resources.yaml -O

ls -la


# Pause before next step
read -p "Press [Enter] to continue to [STEP 2] Deploy the yaml files of Calico Tigera Operator and Calco Custom Resource definitions for Calico v3.30.2..."
echo "[STEP 2] Deploy the yaml files of Calico Tigera Operator and Calco Custom Resource definitions for Calico v3.30.2”

kubectl create -f 00-calico-operator-crds.yaml

kubectl create -f 01-calico-tigera-operator.yaml

kubectl create -f 02-calico-custom-resources.yaml

watch kubectl get pods,svc,tigerastatus -n calico-system

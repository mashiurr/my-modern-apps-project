# k8s-Install NGINX [OSS] Ingress Controller as NodePort (Official Helm) Script as nginx-ingress-np
# in nginx-ingress namespce
# as Controller Class='nginx-ingress'
# with Master-Node IP as External LB IPs

#!/bin/bash
date
set -e  # Exit if any command fails

echo "Installation Script of NGINIX-OSS nginx-ingress-controller as NodePort in nginx-ingress namespace with Service Name nginx-ingress-np as Controller Class=nginx-ingress"

# Step 1: Helm install command
echo "[INFO] Installing NGINX Ingress Controller (NodePort)..."

helm install nginx-ingress-np oci://ghcr.io/nginx/charts/nginx-ingress \
  --version 2.2.1 \
  --namespace nginx-ingress \
  --create-namespace \
  --set controller.service.type=NodePort \
  --set controller.ingressClass.name=nginx-ingress \
  --set controller.nginxStatus.enable=true \
  --set controller.service.externalIPs[0]=10.1.1.4  #<-- Replace with Master's node's external IP 
#  --set controller.tolerations[0].key=node-role.kubernetes.io/control-plane \
#  --set controller.tolerations[0].operator=Exists \
#  --set controller.tolerations[0].effect=NoSchedule \
#  --set controller.nodeSelector."kubernetes\.io/hostname"=master-node #<-- Replace with Master's node's Host Name
#  --set controller.service.ports[0].name="http" \
#  --set controller.service.ports[0].port=31080 \
#  --set controller.service.ports[0].targetPort=31080 \
#  --set controller.service.ports[1].name="https" \
#  --set controller.service.ports[1].port=31443 \
#  --set controller.service.ports[1].targetPort=31443 \
#  --set controller.containerPort.http=31080 \
#  --set controller.containerPort.https=31443
# -f values-for-nginx-ingress-np-customization.yaml

# Step 2: Show status
echo "[INFO] Waiting for NGINX Ingress pods to be ready..."
kubectl wait --namespace nginx-ingress \
  --for=condition=Ready pods \
  --selector=app.kubernetes.io/name=nginx-ingress \
  --timeout=120s

# Step 3: Show resources
echo "[INFO] Deployment complete. Resources in namespace 'nginx-ingress':"
kubectl get all -n nginx-ingress


echo "[Installation Completed !!!] nginx-ingress as NodePort OSS installed in 'nginx-ingress' namespace with Service Name 'nginx-ingress' as Controller Class='nginx-ingress'!" 


## k8s-Uninstall of NGINX Ingress Controller (Official Helm) from nginx-ingres namespace
#!/bin/bash
Echo “This is Uninstall script of NGINX OSS nginx-ingress as NodePort installed in nginx-ingress namespace”
date
set -e

helm uninstall nginx-ingress-np --namespace nginx-ingress
kubectl delete namespace nginx-ingress

echo "[Uninstallation Completed !!!] of NGINX OSS “nginx-ingress-np” Services as ingressClass ‘nginx-ingress’ & Namespace ‘nginx-ingress’ deleted!" 

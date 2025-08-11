## k8s-Uninstall of NGINX Ingress Controller (Official Helm) from nginx-ingres-lb-oss namespace
#!/bin/bash
Echo “This is Uninstall script of NGINX OSS nginx-ingress as LB installed in ‘nginx-ingress-lb-oss namespace”
date
set -e
helm uninstall nginx-ingress-lb-oss --namespace nginx-ingress-lb-oss
kubectl delete namespace nginx-ingress-lb-oss

echo "[Uninstallation Completed !!!] of NGINX OSS “nginx-ingress-lb-oss” Services as ingressClass ‘nginx-ingress-lb-oss’ & Namespace ‘nginx-ingress-lb-oss’ deleted!" 

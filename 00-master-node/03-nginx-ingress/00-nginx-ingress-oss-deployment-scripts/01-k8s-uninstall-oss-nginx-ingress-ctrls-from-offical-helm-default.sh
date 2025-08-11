## k8s-Uninstall of NGINX Ingress Controller (Official Helm) from ‘defau;t’ namespace
#!/bin/bash
Echo “This is Uninstall script of NGINX OSS nginx-ingress as LB installed in ‘default’ namespace”
date
set -e
helm uninstall nginx-ingress

echo "[Uninstallation Completed !!] of NGINX OSS “nginx-ingress” LB Services as ingressClass ‘nginx’ from ‘default’ namespace!"

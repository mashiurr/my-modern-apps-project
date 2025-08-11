#!/bin/bash

kubectl patch svc kubernetes-dashboard \
  -n kubernetes-dashboard \
  -p '{"spec": {"type": "NodePort", "ports": [{"port": 443, "targetPort": 8443, "nodePort": 32443}]}}'

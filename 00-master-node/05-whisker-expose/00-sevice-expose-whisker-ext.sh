#!/bin/bash
kubectl expose service whisker \
  --type=NodePort \
  --port=8081 \
  --target-port=8081 \
  --name=whisker-ext \
  --namespace=calico-system

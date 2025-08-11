#!/bin/bash
date
set -e

echo "Drain Master Node"
kubectl drain master-node --ignore-daemonsets --delete-emptydir-data --force


#!/bin/bash
set -e

kubectl delete all -l app=productpage
kubectl delete all -l app=ratings
kubectl delete all -l app=reviews
kubectl delete all -l app=details

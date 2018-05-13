#!/bin/bash
set -e

HERE=$(dirname "$(readlink -f "$0")")

cd "$HERE/istio"

kubectl apply -f install/kubernetes/istio.yaml
kubectl apply -f install/kubernetes/addons/prometheus.yaml
kubectl apply -f install/kubernetes/addons/grafana.yaml
kubectl apply -f install/kubernetes/addons/servicegraph.yaml

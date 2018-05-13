#!/bin/bash
set -e

HERE=$(dirname "$(readlink -f "$0")")

cd "$HERE/istio"

kubectl apply -f <(bin/istioctl kube-inject --debug -f samples/bookinfo/kube/bookinfo.yaml)

#!/bin/bash
set -e

HERE=$(dirname "$(readlink -f "$0")")

xdg-open "http://localhost:8088/force/forcegraph.html"
xdg-open "http://localhost:8088/dotviz"

kubectl -n istio-system port-forward $("$HERE/utils/get-first-pod-name.sh" -n istio-system -l app=servicegraph) 8088:8088 &


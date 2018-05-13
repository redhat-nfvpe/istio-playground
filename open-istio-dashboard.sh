#!/bin/bash
set -e

HERE=$(dirname "$(readlink -f "$0")")

xdg-open "http://localhost:3000/dashboard/db/istio-dashboard"

kubectl -n istio-system port-forward $("$HERE/utils/get-first-pod-name.sh" -n istio-system -l app=grafana) 3000:3000 &

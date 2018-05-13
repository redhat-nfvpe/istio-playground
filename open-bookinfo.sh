#!/bin/bash
set -e

HERE=$(dirname "$(readlink -f "$0")")

xdg-open "http://localhost:9080"

kubectl port-forward $("$HERE/utils/get-first-pod-name.sh" -l app=productpage) 9080:9080 &

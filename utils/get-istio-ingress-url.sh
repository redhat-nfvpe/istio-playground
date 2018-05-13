#!/bin/bash
set -e

echo "http://$(kubectl get pods -l istio=ingress -n istio-system -o 'jsonpath={.items[0].status.hostIP}'):$(kubectl get services istio-ingress -n istio-system -o 'jsonpath={.spec.ports[0].nodePort}')/"

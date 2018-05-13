#!/bin/bash
set -e

kubectl get pods "$@" -o jsonpath='{.items[0].metadata.name}'

#!/bin/bash
set -e

HERE=$(dirname "$(readlink -f "$0")")

. "$HERE/utils/versions.sh"

if [ ! -d "$HERE/istio" ]; then
	cd "$HERE"
	curl -L https://git.io/getLatestIstio | sh -
	mv "istio-$ISTIO_VERSION" istio
fi

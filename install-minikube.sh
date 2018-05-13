#!/bin/bash
set -e

HERE=$(dirname "$(readlink -f "$0")")

. "$HERE/utils/versions.sh"

if [ "$EUID" -ne 0 ]; then
	echo "Run this script as root"
	exit 1
fi

fetch () {
	local NAME=$1
	local URL=$2
	local EXEC="/usr/bin/$NAME"
	if [ ! -f "$EXEC" ]; then
		wget -O "$EXEC" "$URL"
		chmod +x "$EXEC"
	fi
}

fetch_tarball ()
{
	local NAME=$1
	local URL=$2
	local DIR=$3
	local EXEC="/usr/bin/$NAME"
	if [ ! -f "$EXEC" ]; then
		cd /tmp
		rm --force kube.tgz
		wget -O kube.tgz "$URL"
		tar xf kube.tgz "$DIR/$NAME"
		chmod +x "$DIR/$NAME"
		mv "$DIR/$NAME" /usr/bin
		rm --force --recursive kube.tgz "$DIR"
	fi
}

fetch kubectl "https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl"
fetch minikube "https://storage.googleapis.com/minikube/releases/v$MINIKUBE_VERSION/minikube-linux-amd64"
fetch_tarball minishift "https://github.com/minishift/minishift/releases/download/v$MINISHIFT_VERSION/minishift-$MINISHIFT_VERSION-linux-amd64.tgz" "minishift-$MINISHIFT_VERSION-linux-amd64"

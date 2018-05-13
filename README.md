Istio Playground
================

Play around with [Istio](https://istio.io/) in a local virtual machine using
[Minikube](https://github.com/kubernetes/minikube).

Let's install Minikube and Istio:

    sudo ./install-minikube.sh
    ./install-istio.sh

`sudo` is necessary to install `minikube` and `kubectl` under `/usr/bin/`. Istio will be installed
under the local `istio/` directory.

Let's start Minikube:

    ./start-minikube.sh

Wait a minute or two for the magic to happen. It will then open the Kubernetes Dashboard in your web
browser.

From now on note that when you apply new applications it may take a minute or two for containers to
install and start, so be patient and keep refreshing your browser. You can always look at what's
going on in the Kubernetes Dashboard. 

Let's apply Istio and its add-ons to our Kubernetes cluster:

    ./apply-istio.sh

In the Kubernetes Dashboard change the namespace to "istio-system" to see its workloads. Now let's
open the Istio Dashboard ([Grafana](https://grafana.com/)):

    ./open-istio-dashboard.sh

Let's open the Istio Service Graph (two pages):

    ./open-istio-service-graph.sh

Not much to see yet! Let's apply our demo application (Bookinfo) and open its page:

    ./apply-bookinfo.sh
    ./open-bookinfo.sh

OK, so now we can start generating some service mesh data. Click on the "normal user" and refresh
many times. The Istio Dashboard will start showing data flowing and the Service Graph page will
display your mesh graph. Hooray!

When you're done playing, shut down the port forwarding we've been doing in the background:

    killall kubectl

To delete Bookinfo:

    istio/samples/bookinfo/kube/cleanup.sh

To delete your Minikube virtual machine:

    minikube delete


Interesting Things to Do
------------------------

See how Istio injects its sidecar:

    vim istio/samples/bookinfo/kube/bookinfo.yaml
    istio/bin/istioctl kube-inject -f istio/samples/bookinfo/kube/bookinfo.yaml | vim - -c 'set syntax=yaml'

Create virtual services:

    istio/bin/istioctl create -f istio/samples/bookinfo/routing/route-rule-all-v1.yaml
    istio/bin/istioctl get virtualservices -o yaml | vim - -c 'set syntax=yaml'
    istio/bin/istioctl get destinationrules -o yaml | vim - -c 'set syntax=yaml'
    istio/bin/istioctl delete -f istio/samples/bookinfo/routing/route-rule-all-v1.yaml

Get a shell into a sidecar to see how it routes to Envoy at port 15001: (also see
[video here](https://developer.ibm.com/dwblog/2017/how-istio-manages-microservice-applications/))

    kubectl exec -it $(utils/get-first-pod-name.sh -l app=productpage) -c istio-proxy /bin/bash
    sudo iptables -L -n -t nat

Get a shell into the Istio ingress container:

    kubectl exec -it -n istio-system $(utils/get-first-pod-name.sh -n istio-system -l istio=ingress) /bin/bash

Get a throwaway shell into the cluster:

    kubectl run -it --rm --restart=Never busybox --image=busybox sh
    wget -qO- productpage:9080

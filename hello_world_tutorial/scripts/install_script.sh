#!/usr/bin/env bash

KEPTN_VERSION=0.14.2

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

wget https://github.com/keptn/keptn/releases/download/$KEPTN_VERSION/keptn-$KEPTN_VERSION-linux-amd64.tar.gz && \
    tar -xf keptn-$KEPTN_VERSION-linux-amd64.tar.gz && \
	cp keptn-$KEPTN_VERSION-linux-amd64 /usr/local/bin/keptn

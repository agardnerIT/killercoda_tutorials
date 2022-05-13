#!/usr/bin/env bash

KEPTN_VERSION=0.14.2

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

wget https://github.com/keptn/keptn/releases/download/$KEPTN_VERSION/keptn-$KEPTN_VERSION-linux-amd64.tar.gz && \
    tar -xf keptn-$KEPTN_VERSION-linux-amd64.tar.gz && \
	cp keptn-$KEPTN_VERSION-linux-amd64 /usr/local/bin/keptn
	
kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus --namespace monitoring --wait

curl -sL https://get.keptn.sh | KEPTN_VERSION=$KEPTN_VERSION bash
# Install Keptn into 'keptn' namespace
# Note: You might need to change this from LoadBalancer to ClusterIP
# If you do so, you'll need to use port-forward
helm repo add keptn https://charts.keptn.sh
helm repo update
helm upgrade --install keptn keptn/keptn --version $KEPTN_VERSION \
-n keptn --create-namespace \
--wait \
--set=control-plane.apiGatewayNginx.type=LoadBalancer

KEPTN_API_PROTOCOL=http # or https
KEPTN_API_HOST=api-gateway-nginx.keptn
KEPTN_API_TOKEN=$(kubectl -n keptn get secret keptn-api-token -o=jsonpath={.data.keptn-api-token} | base64 -d)
TASK_SUBSCRIPTION='sh.keptn.event.je-deployment.triggered\,sh.keptn.event.je-test.triggered'
helm upgrade --install --create-namespace -n keptn-jes \
  job-executor-service https://github.com/keptn-contrib/job-executor-service/releases/download/0.2.0/job-executor-service-0.2.0.tgz \
 --set remoteControlPlane.topicSubscription="${TASK_SUBSCRIPTION}",remoteControlPlane.api.protocol=${KEPTN_API_PROTOCOL},remoteControlPlane.api.hostname=${KEPTN_API_HOST},remoteControlPlane.api.token=${KEPTN_API_TOKEN}
 
kubectl apply -f https://raw.githubusercontent.com/christian-kreuzberger-dtx/keptn-job-executor-delivery-poc/main/job-executor/workloadClusterRoles.yaml
 
helm upgrade --install -n keptn prometheus-service https://github.com/keptn-contrib/prometheus-service/releases/download/0.8.0/prometheus-service-0.8.0.tgz --wait
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-service/0.8.0/deploy/role.yaml -n monitoring

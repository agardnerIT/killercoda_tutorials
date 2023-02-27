# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
DEBUG_VERSION=2
GH_CLI_VERSION=2.23.0
KEPTN_VERSION=1.2.0
JOB_EXECUTOR_SERVICE_VERSION=0.3.0
JOB_EXECUTOR_NAMESPACE=keptn-jes
KEPTN_PROMETHEUS_SERVICE_VERSION=0.9.1
PROMETHEUS_VERSION=19.0.1
POD_WAIT_TIMEOUT_MINS=10

helm install keptn https://github.com/keptn/keptn/releases/download/$KEPTN_VERSION/keptn-$KEPTN_VERSION.tgz \
-n keptn --create-namespace \
--set mongo.resources.requests.cpu=0 \
--set mongo.resources.requests.memory=0 \
--set nats.nats.resources.requests.cpu=0 \
--set nats.nats.resources.requests.memory=0 \
--set nats.nats.jetstream.memStorage.size=0M \
--set apiGatewayNginx.resources.requests.cpu=0 \
--set apiGatewayNginx.resources.requests.memory=0 \
--set remediationService.resources.requests.cpu=0 \
--set remediationService.resources.requests.memory=0 \
--set apiService.resources.requests.cpu=0 \
--set apiService.resources.requests.memory=0 \
--set bridge.versionCheck.enabled=false \
--set bridge.resources.requests.cpu=0 \
--set bridge.resources.requests.memory=0 \
--set distributor.resources.requests.cpu=0 \
--set distributor.resources.requests.memory=0 \
--set shipyardController.resources.requests.cpu=0 \
--set shipyardController.resources.requests.memory=0 \
--set secretService.resources.requests.cpu=0 \
--set secretService.resources.requests.memory=0 \
--set configurationService.resources.requests.cpu=0 \
--set configurationService.resources.requests.memory=0 \
--set resourceService.resources.requests.cpu=0 \
--set resourceService.resources.requests.memory=0 \
--set mongodbDatastore.resources.requests.cpu=0 \
--set mongodbDatastore.resources.requests.memory=0 \
--set lighthouseService.resources.requests.cpu=0 \
--set lighthouseService.resources.requests.memory=0 \
--set statisticsService.enabled=false \
--set approvalService.resources.requests.cpu=0 \
--set approvalService.resources.requests.memory=0 \
--set webhookService.resources.requests.cpu=0 \
--set webhookService.resources.requests.memory=0

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus \
--namespace monitoring --create-namespace \
--version ${PROMETHEUS_VERSION}

helm install -n keptn prometheus-service https://github.com/keptn-contrib/prometheus-service/releases/download/$KEPTN_PROMETHEUS_SERVICE_VERSION/prometheus-service-$KEPTN_PROMETHEUS_SERVICE_VERSION.tgz --set resources.requests.cpu=0m

KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 -d)
helm install --namespace $JOB_EXECUTOR_NAMESPACE \
--create-namespace \
--set=remoteControlPlane.api.hostname=api-gateway-nginx.keptn \
--set=remoteControlPlane.api.token=$KEPTN_API_TOKEN --set=remoteControlPlane.topicSubscription="sh.keptn.event.deployment.triggered\,sh.keptn.event.test.triggered\,sh.keptn.event.action.triggered" \
job-executor-service https://github.com/keptn-contrib/job-executor-service/releases/download/$JOB_EXECUTOR_SERVICE_VERSION/job-executor-service-$JOB_EXECUTOR_SERVICE_VERSION.tgz
kubectl apply -f https://raw.githubusercontent.com/christian-kreuzberger-dtx/keptn-job-executor-delivery-poc/main/job-executor/workloadClusterRoles.yaml

curl -sL https://get.keptn.sh | KEPTN_VERSION=$KEPTN_VERSION bash

wget -q https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.deb
chmod +x gh_${GH_CLI_VERSION}_linux_amd64.deb
dpkg -i gh_${GH_CLI_VERSION}_linux_amd64.deb

#################################
# 🎉 Installation Complete 🎉
# Please proceed...
#################################
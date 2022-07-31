# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
K3D_VERSION=v5.3.0
KUBECTL_VERSION=v1.22.6
GH_CLI_VERSION=2.14.1
KEPTN_VERSION=0.17.0
JOB_EXECUTOR_SERVICE_VERSION=0.2.3
KEPTN_PROMETHEUS_SERVICE_VERSION=0.8.3
PROMETHEUS_VERSION=15.10.1
DEBUG_VERSION=10

# -----------------------------------------#
#    Step 1/11: Installing GitHub CLI      #
# -----------------------------------------#
wget -q https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.deb
chmod +x gh_${GH_CLI_VERSION}_linux_amd64.deb
dpkg -i gh_${GH_CLI_VERSION}_linux_amd64.deb

# -----------------------------------------#
#    Step 2/11: Retrieving demo files      #
# -----------------------------------------#
git clone https://github.com/christian-kreuzberger-dtx/keptn-job-executor-delivery-poc.git

# -----------------------------------------#
#      Step 3/11: Installing Keptn CLI     #
# -----------------------------------------#
# curl -sL https://get.keptn.sh | KEPTN_VERSION=$KEPTN_VERSION bash

# ----------------------------------------#
#      Step 4/11: Installing Helm         #
# ----------------------------------------#
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh
./get_helm.sh

# ----------------------------------------#
#      Step 5/11: Installing Kubectl      #
# ----------------------------------------#
curl -LO https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# -----------------------------------------#
#    Step 6/11: Initialising Kubernetes    #
# -----------------------------------------#
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=$K3D_VERSION bash
k3d cluster create mykeptn -p "8080:80@loadbalancer" -p "3000:3000@loadbalancer" --k3s-arg "--no-deploy=traefik@server:*"

# WIP: Install Gitea
helm repo add gitea-charts https://dl.gitea.io/charts/
helm repo update
helm install gitea gitea-charts/gitea \
--namespace gitea --create-namespace \
--set image.pullPolicy=IfNotPresent \
--set image.tag=1.17.0 \
--set service.http.type=LoadBalancer \
--set service.http.port=3000 \
--set persistence.enabled=false \
--set memcached.enabled=false \
--set postgresql.enabled=false

# -----------------------------------------#
#    Step 7/11: Installing Prometheus      #
# -----------------------------------------#
# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace --version ${PROMETHEUS_VERSION} --wait

# -------------------------------------------#
# Step 8/11: Installing Keptn Control Plane  #
# -------------------------------------------#
# helm install keptn https://github.com/keptn/keptn/releases/download/$KEPTN_VERSION/keptn-$KEPTN_VERSION.tgz -n keptn --timeout=5m --wait --create-namespace --set=apiGatewayNginx.type=LoadBalancer

# --------------------------------------------#
# Step 9/11: Installing Job Executor Service  #
# --------------------------------------------#
# KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 -d)
# helm install --namespace keptn-jes --create-namespace --wait --timeout=4m --set=remoteControlPlane.api.hostname=api-gateway-nginx.keptn --set=remoteControlPlane.api.token=$KEPTN_API_TOKEN --set=remoteControlPlane.topicSubscription="sh.keptn.event.je-deployment.triggered\,sh.keptn.event.je-test.triggered\,sh.keptn.event.action.triggered" \
# job-executor-service https://github.com/keptn-contrib/job-executor-service/releases/download/$JOB_EXECUTOR_SERVICE_VERSION/job-executor-service-$JOB_EXECUTOR_SERVICE_VERSION.tgz

# --------------------------------------------#
# Step 10/11: Installing Prometheus Service   #
# --------------------------------------------#
# helm install -n keptn prometheus-service https://github.com/keptn-contrib/prometheus-service/releases/download/$KEPTN_PROMETHEUS_SERVICE_VERSION/prometheus-service-$KEPTN_PROMETHEUS_SERVICE_VERSION.tgz --set resources.requests.cpu=25m
# kubectl -n monitoring apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-service/$KEPTN_PROMETHEUS_SERVICE_VERSION/deploy/role.yaml

# ---------------------------------------------#
# Step 11/11: Apply Cluster Admin Role for JES #
# ---------------------------------------------#
# kubectl apply -f ~/keptn-job-executor-delivery-poc/job-executor/workloadClusterRoles.yaml

# ---------------------------------------------#
#       🎉 Installation Complete 🎉          #
#           Please proceed now...              #
# ---------------------------------------------#

# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
HELM_VERSION=v3.9.2
KEPTN_VERSION=0.17.0
JOB_EXECUTOR_SERVICE_VERSION=0.2.3

# Set global variables
HELM_VERSION=v3.9.2
KEPTN_VERSION=0.17.0
JOB_EXECUTOR_SERVICE_VERSION=0.2.3
PV_SIZE=500M

# Install helm
wget https://get.helm.sh/helm-$HELM_VERSION-linux-386.tar.gz
gzip -d helm-$HELM_VERSION-linux-386.tar.gz
tar -xf helm-$HELM_VERSION-linux-386.tar
sudo cp linux-386/helm /usr/local/bin/helm

# Install k3s
curl -sfL https://get.k3s.io | sh -
mkdir ~/.kube
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

# Install keptn CLI
curl -sL https://get.keptn.sh | KEPTN_VERSION=$KEPTN_VERSION bash

# Install Keptn control plane
helm install keptn https://github.com/keptn/keptn/releases/download/$KEPTN_VERSION/keptn-$KEPTN_VERSION.tgz -n keptn --timeout=5m --wait --create-namespace \
  --set=apiGatewayNginx.type=LoadBalancer \
  --set=nats.nats.jetstream.fileStorage.size=$PV_SIZE \
  --set=mongo.persistence.size=$PV_SIZE

# Install JES
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 -d)
helm install --namespace keptn-jes --create-namespace --wait --timeout=4m --set=remoteControlPlane.api.hostname=api-gateway-nginx.keptn --set=remoteControlPlane.api.token=$KEPTN_API_TOKEN --set=remoteControlPlane.topicSubscription="sh.keptn.event.test.triggered" \
job-executor-service https://github.com/keptn-contrib/job-executor-service/releases/download/$JOB_EXECUTOR_SERVICE_VERSION/job-executor-service-$JOB_EXECUTOR_SERVICE_VERSION.tgz

# Clone demo
git clone https://github.com/kubeshop/tracetest
cd ~/tracetest

# Customise setup.sh for killercoda
# 1. Shrink postgres cpu requests and disk size from 8Gi to $PV_SIZE setting
# 2. Shrink rabbitmq disk from 8Gi to $PV_SIZE setting
# 3. Shrink redis disk from 8Gi to $PV_SIZE setting
# 4. Remove instructions for port-forwarding
# 5. Expose tracetest on LB :8080 (rather than port-forward)

# Add custom CPU requests
# https://artifacthub.io/packages/helm/bitnami/postgresql
# https://artifacthub.io/packages/helm/bitnami/rabbitmq
# https://artifacthub.io/packages/helm/bitnami/redis
sed -i "s#--set postgres.auth.username=ashketchum,postgres.auth.password=squirtle123,postgres.auth.database=pokeshop \\#--set postgres.auth.username=ashketchum,postgres.auth.password=squirtle123,postgres.auth.database=pokeshop,postgresql.primary.resources.requests.cpu=10m,postgresql.primary.persistence.size=$PV_SIZE \\#g" ~/tracetest/setup.sh
sed -i "s#--set server.telemetry.dataStore=\"${TRACE_BACKEND}\"#--set server.telemetry.dataStore=\"${TRACE_BACKEND}\" --set postgresql.primary.resources.requests.cpu=10m,postgresql.primary.persistence.size=$PV_SIZE#g" ~/tracetest/setup.sh
sed -i "s#--set rabbitmq.auth.username=guest,rabbitmq.auth.password=guest,rabbitmq.auth.erlangCookie=secretcookie \\#--set rabbitmq.auth.username=guest,rabbitmq.auth.password=guest,rabbitmq.auth.erlangCookie=secretcookie,rabbitmq.persistence.size=$PV_SIZE --set redis.master.persistence.size=$PV_SIZE \\#g" ~/tracetest/setup.sh

# Remove final 13 lines (port-forward instructions)
head -n -13 ~/tracetest/setup.sh > /tmp/setup.sh && mv /tmp/setup.sh ~/tracetest/setup.sh

# Expose tracetest on LB :8080
echo "kubectl --namespace tracetest patch svc/tracetest -p '{\"spec\": {\"ports\": [{\"port\": 8080,\"targetPort\": 8080,\"name\": \"http\"}],\"type\": \"LoadBalancer\"}}'" >> ~/tracetest/setup.sh

# Add friendly message
echo "echo \"Customised tracetest setup.sh complete\"" >> ~/tracetest/setup.sh

# Run customised tracetest setup.sh
chmod +x ~/tracetest/setup.sh
~/tracetest/setup.sh


# ---------------------------------------------#
#       🎉 Installation Complete 🎉          #
#           Please proceed now...              #
# ---------------------------------------------#
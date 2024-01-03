DEBUG_VERSION=2
DEMO_APP_PORT=30000
CERT_MANAGER_VERSION=v1.13.2
OPENFEATURE_OPERATOR_VERSION=v0.5.3
#########################################################
# 1/3: Installing Cert Manager                          #
#########################################################
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version ${CERT_MANAGER_VERSION} \
  --set installCRDs=true \
  --wait

# Create OFO namespace
kubectl apply -f ~/open-feature-operator-namespace.yaml

# Install OFO
kubectl apply -f https://github.com/open-feature/open-feature-operator/releases/download/v0.5.3/release.yaml && \
kubectl wait --timeout=60s --for condition=Available=True deploy --all -n 'open-feature-operator-system'

# Get external URL
# Format: abc1234-PORT.papa.r.killercoda.com
FLAGD_HOST_WEB=$(cat /etc/killercoda/host)
# replace string literal "PORT" with the port (30002)
FLAGD_HOST_WEB_REPLACED=$(echo "${FLAGD_HOST_WEB/PORT/"30002"}")
# Overwrite placeholder with dynamic value in ~/end-to-end.yaml
sed -i "s/FLAGD_HOST_WEB_PLACEHOLDER/$FLAGD_HOST_WEB_REPLACED/g" ~/end-to-end.yaml

# Apply workload and config
kubectl apply -f ~/end-to-end.yaml
kubectl wait --timeout=60s deployment --for condition=Available=True -l 'app=open-feature-demo' -n 'default'
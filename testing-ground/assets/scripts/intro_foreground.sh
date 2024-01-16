DEBUG_VERSION=6
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
kubectl apply -f https://github.com/open-feature/open-feature-operator/releases/download/${OPENFEATURE_OPERATOR_VERSION}/release.yaml && \
kubectl wait --timeout=60s --for condition=Available=True deploy --all -n 'open-feature-operator-system'

# Get external URL
# Format: abc1234-PORT.papa.r.killercoda.com
FLAGD_HOST_WEB=$(cat /etc/killercoda/host)
# replace string literal "PORT" with the port (30002)
FLAGD_HOST_WEB_REPLACED=$(echo "${FLAGD_HOST_WEB/PORT/"30002"}")
# and remove "https://" (flagd adds it due to `FLAGD_TLS_WEB: true` in end-to-end.yaml)
FLAGD_HOST_WEB_REPLACED=$(echo "${FLAGD_HOST_WEB_REPLACED/"https://"/""}")
# Overwrite placeholder with dynamic value in ~/end-to-end.yaml
sed -i "s#FLAGD_HOST_WEB_PLACEHOLDER#$FLAGD_HOST_WEB_REPLACED#g" ~/end-to-end.yaml

# Apply workload and config
kubectl apply -f ~/end-to-end.yaml
kubectl wait --timeout=120s deployment --for condition=Available=True -l 'app=open-feature-demo' -n 'default'

# ---------------------------------------------#
#       🎉 Installation Complete 🎉           #
#           Please proceed now...              #
# ---------------------------------------------#
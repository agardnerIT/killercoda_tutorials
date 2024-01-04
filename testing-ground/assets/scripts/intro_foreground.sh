DEBUG_VERSION=1
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

# Apply workload and config
kubectl apply -f ~/end-to-end.yaml
sleep 10
kubectl wait pods -n open-feature-demo -l app=open-feature-demo --for condition=Ready --timeout=30s
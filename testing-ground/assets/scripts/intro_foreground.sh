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
helm repo add openfeature https://open-feature.github.io/open-feature-operator/
helm install openfeature-operator openfeature/open-feature-operator --version ${OPENFEATURE_OPERATOR_VERSION} --namespace open-feature-operator-system --wait

# Apply workload and config
kubectl apply -f ~/end-to-end.yaml
sleep 10
kubectl wait pods -n open-feature-demo -l app=open-feature-demo --for condition=Ready --timeout=30s
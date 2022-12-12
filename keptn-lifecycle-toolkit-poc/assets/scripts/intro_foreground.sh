DEBUG_VERSION=1

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.yaml
kubectl wait --for=condition=Available deployment/cert-manager-webhook -n cert-manager --timeout=60s
kubectl apply -f https://github.com/keptn/lifecycle-toolkit/releases/download/v0.4.0/manifest.yaml
kubectl wait --for=condition=Available deployment/klc-controller-manager -n keptn-lifecycle-toolkit-system --timeout=120s

git clone https://github.com/keptn-sandbox/keptn-lifecycle-toolkit-examples.git
cd keptn-lifecycle-toolkit-examples
make install-observability
##############################################
# 1/4: Install Keptn Lifecycle Toolkit
##############################################
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait

##############################################
# 2/4: Clone Example Code
##############################################
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git

##############################################
# 3/4: Install Observability Tooling
# cert-manager
# OpenTelemetry Collector
# Jaeger
# Prometheus Mockserver
##############################################
cd ~/lifecycle-toolkit-examples
make install-observability
make restart-lifecycle-toolkit

##############################################
# 4/4: Prevent Annoying "got empty response" errors (noise).
# TODO: Understand impact (if any), of this
# https://github.com/helm/helm/issues/11772#issuecomment-1416558925
##############################################
kubectl delete apiservices v1beta1.custom.metrics.k8s.io
kubectl delete apiservices v1beta2.custom.metrics.k8s.io

##############################################
# 🎉 Installation Complete 🎉
# Please proceed...
##############################################
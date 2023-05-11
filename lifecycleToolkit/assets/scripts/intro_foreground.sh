DEBUG_VERSION=2

##############################################
# 1/5: Install Keptn Lifecycle Toolkit
##############################################
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait

##############################################
# 2/5: Clone Example Code
##############################################
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git

##############################################
# 3/5: Install Observability Tooling
# cert-manager
# OpenTelemetry Collector
# Jaeger
# Prometheus Mockserver
##############################################
cd ~/lifecycle-toolkit-examples
make install-observability
make restart-lifecycle-toolkit

##############################################
# 4/5: Prevent Annoying "got empty response" errors (noise).
# https://github.com/helm/helm/issues/11772#issuecomment-1416558925
##############################################
kubectl delete apiservices v1beta1.custom.metrics.k8s.io
kubectl delete apiservices v1beta2.custom.metrics.k8s.io

##############################################
# 5/5: Killercoda fix: Port Forwarding needs 0.0.0.0
# Note: This is only a fix for killercoda
##############################################
sed -i "s#kubectl port-forward -n \"\$(TOOLKIT_NAMESPACE)\" svc/jaeger-query 16686#kubectl port-forward -n \"\$(TOOLKIT_NAMESPACE)\" --address 0.0.0.0 svc/jaeger-query 16686#g" ~/lifecycle-toolkit-examples/support/observability/Makefile
sed -i "s#kubectl port-forward svc/argocd-server -n \"\$(ARGO_NAMESPACE)\" 8080:443#kubectl port-forward svc/argocd-server -n \"\$(ARGO_NAMESPACE)\" --address 0.0.0.0 8080:443#g" ~/lifecycle-toolkit-examples/Makefile
sed -i "s#kubectl -n monitoring port-forward svc/prometheus-k8s 9090#kubectl -n monitoring port-forward --address 0.0.0.0 svc/prometheus-k8s 9090#g" ~/lifecycle-toolkit-examples/support/observability/Makefile
sed -i "s#kubectl -n monitoring port-forward svc/grafana \$(GRAFANA_PORT_FORWARD):3000#kubectl -n monitoring port-forward --address 0.0.0.0 svc/grafana \$(GRAFANA_PORT_FORWARD):3000#g" ~/lifecycle-toolkit-examples/support/observability/Makefile
nohup make port-forward-jaeger &
nohup make port-forward-prometheus &
nohup make port-forward-grafana &
nohup make port-forward-jaeger &

##############################################
# 🎉 Installation Complete 🎉
# Please proceed...
##############################################
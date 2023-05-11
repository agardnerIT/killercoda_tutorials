DEBUG_VERSION=5
YQ_VERSION=v4.33.3

##############################################
# 1/8: Download tools
##############################################
wget -O ~/usr/bin/yq https://github.com/mikefarah/yq/releases/download/$(YQ_VERSION)/yq_linux_amd64

##############################################
# 2/8: Install Keptn Lifecycle Toolkit
##############################################
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait

##############################################
# 3/8: Clone Example Code
##############################################
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git


##############################################
# 4/8: Killercoda fix: lower CPU and memory requests
# YQ expression from here: https://github.com/mikefarah/yq/issues/513#issuecomment-862617657
##############################################

yq eval '. | select(.kind == "Deployment") as $deployment | select(.kind != "Deployment") as $other | $deployment.spec.template.spec.containers[0].resources.requests.cpu = "1m" | ($deployment, $other)' -i ~/lifecycle-toolkit-examples/support/metrics/deployment.yaml
yq eval '. | select(.kind == "Deployment") as $deployment | select(.kind != "Deployment") as $other | $deployment.spec.template.spec.containers[0].resources.requests.memory = "1Mi" | ($deployment, $other)' -i ~/lifecycle-toolkit-examples/support/metrics/deployment.yaml
yq eval -i '.spec.resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/alertmanager-alertmanager.yaml
yq eval -i '.spec.resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/alertmanager-alertmanager.yaml
yq eval -i '.spec.resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/prometheus-prometheus.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/node-exporter-daemonset.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/node-exporter-daemonset.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/blackbox-exporter-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/blackbox-exporter-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/blackbox-exporter-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/blackbox-exporter-deployment.yaml
yq eval -i '.spec.template.spec.containers[2].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/blackbox-exporter-deployment.yaml
yq eval -i '.spec.template.spec.containers[2].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/blackbox-exporter-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/kube-state-metrics-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/kube-state-metrics-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/kube-state-metrics-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/kube-state-metrics-deployment.yaml
yq eval -i '.spec.template.spec.containers[2].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/kube-state-metrics-deployment.yaml
yq eval -i '.spec.template.spec.containers[2].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/kube-state-metrics-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/grafana-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/grafana-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/prometheus-adapter-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/prometheus-adapter-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/setup/prometheus-operator-deployment.yaml
yq eval -i '.spec.template.spec.containers[0].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/setup/prometheus-operator-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/setup/prometheus-operator-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/setup/prometheus-operator-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/setup/prometheus-operator-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.memory = "1Mi"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/setup/prometheus-operator-deployment.yaml
yq eval -i '.spec.template.spec.containers[1].resources.requests.cpu = "1m"' ~/lifecycle-toolkit-examples/support/observability/config/prometheus/setup/prometheus-operator-deployment.yaml
yq eval '. | select(.kind == "Deployment") as $deployment | select(.kind != "Deployment") as $other | $deployment.spec.template.spec.containers[0].resources.requests.cpu = "1m" | ($deployment, $other)' -i ~/lifecycle-toolkit-examples/support/observability/config/otel-collector.yaml
yq eval '. | select(.kind == "Deployment") as $deployment | select(.kind != "Deployment") as $other | $deployment.spec.template.spec.containers[0].resources.requests.memory = "1Mi" | ($deployment, $other)' -i ~/lifecycle-toolkit-examples/support/observability/config/otel-collector.yaml


##############################################
# 5/8: Install Observability Tooling
# cert-manager
# OpenTelemetry Collector
# Jaeger
# Prometheus Mockserver
##############################################
cd ~/lifecycle-toolkit-examples
make install-observability

##############################################
# 6/8: Prevent Annoying "got empty response" errors (noise).
# https://github.com/helm/helm/issues/11772#issuecomment-1416558925
##############################################
kubectl delete apiservices v1beta1.custom.metrics.k8s.io
kubectl delete apiservices v1beta2.custom.metrics.k8s.io

##############################################
# 7/8: Restart toolkit
# to re-read ConfigMaps
##############################################
make restart-lifecycle-toolkit

##############################################
# 8/8: Killercoda fix: Port Forwarding needs 0.0.0.0
# Note: This is only a fix for killercoda
##############################################
sed -i "s#kubectl port-forward -n \"\$(TOOLKIT_NAMESPACE)\" svc/jaeger-query 16686#kubectl port-forward -n \"\$(TOOLKIT_NAMESPACE)\" --address 0.0.0.0 svc/jaeger-query 16686#g" ~/lifecycle-toolkit-examples/support/observability/Makefile
sed -i "s#kubectl -n monitoring port-forward svc/prometheus-k8s 9090#kubectl -n monitoring port-forward --address 0.0.0.0 svc/prometheus-k8s 9090#g" ~/lifecycle-toolkit-examples/support/observability/Makefile
sed -i "s#kubectl port-forward svc/argocd-server -n \"\$(ARGO_NAMESPACE)\" 8080:443#kubectl port-forward svc/argocd-server -n \"\$(ARGO_NAMESPACE)\" --address 0.0.0.0 8080:443#g" ~/lifecycle-toolkit-examples/Makefile
sed -i "s#kubectl -n monitoring port-forward svc/grafana \$(GRAFANA_PORT_FORWARD):3000#kubectl -n monitoring port-forward --address 0.0.0.0 svc/grafana \$(GRAFANA_PORT_FORWARD):3000#g" ~/lifecycle-toolkit-examples/support/observability/Makefile
nohup make port-forward-jaeger &
nohup make port-forward-prometheus &
nohup make port-forward-argocd &
nohup make port-forward-grafana &

##############################################
# 🎉 Installation Complete 🎉
# Please proceed...
##############################################
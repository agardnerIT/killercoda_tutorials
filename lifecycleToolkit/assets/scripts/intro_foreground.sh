##############################################
# 1/3: Install Keptn Lifecycle Toolkit
##############################################
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait

##############################################
# 2/3: Clone Example Code
##############################################
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git

##############################################
# 3/3: Install Observability Tooling
# cert-manager
# OpenTelemetry Collector
# Jaeger
# Prometheus Mockserver
##############################################
cd ~/lifecycle-toolkit-examples
make install-observability
make restart-lifecycle-toolkit

#################################
# 🎉 Installation Complete 🎉
# Please proceed...
#################################
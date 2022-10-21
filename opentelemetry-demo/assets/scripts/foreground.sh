helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update
helm install otel-demo open-telemetry/opentelemetry-demo --version 0.9.6

# ---------------------------------------------#
#       🎉 Installation Complete 🎉             #
#           Please proceed now...              #
# ---------------------------------------------#
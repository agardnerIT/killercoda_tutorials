DEBUG_VERSION=2

helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update

# Installing OpenTelemetry demo. This takes about 10 minutes
helm install otel-demo open-telemetry/opentelemetry-demo \
--version 0.9.6 \
--wait \
--set components.frontend.serviceType=LoadBalancer \
--set observability.jaeger.serviceType=LoadBalancer

# ---------------------------------------------#
#       🎉 Installation Complete 🎉             #
#           Please proceed now...              #
# ---------------------------------------------#
OTELCOL_VERSION=0.73.0

wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTELCOL_VERSION}/otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz
tar -xf otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz
mv otelcol-contrib otelcol
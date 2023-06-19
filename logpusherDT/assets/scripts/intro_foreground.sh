OTELCOL_VERSION=0.78.0
LOGPUSHER_VERSION=v0.1.0

docker pull gardnera/logpusher:${TRACEPUSHER_VERSION}
wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTELCOL_VERSION}/otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz
tar -xf otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz
mv otelcol-contrib otelcol
rm otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz

# ---------------------------------------------#
#       🎉 Installation Complete 🎉             #
#           Please proceed now...              #
# ---------------------------------------------#
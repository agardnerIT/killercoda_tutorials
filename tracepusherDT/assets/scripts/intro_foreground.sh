OTELCOL_VERSION=0.73.0
TRACEPUSHER_VERSION=v0.5.0

docker pull gardnera/tracepusher:${TRACEPUSHER_VERSION}
wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTELCOL_VERSION}/otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz
tar -xf otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz
mv otelcol-contrib otelcol
rm otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz

# ---------------------------------------------#
#       🎉 Installation Complete 🎉             #
#           Please proceed now...              #
# ---------------------------------------------#
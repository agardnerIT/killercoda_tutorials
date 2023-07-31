OTELCOL_VERSION=0.78.0
TRACEPUSHER_VERSION=0.8.0

wget -O tracepusher https://github.com/agardnerIT/tracepusher/releases/download/${TRACEPUSHER_VERSION}/tracepusher_linux_x64_${TRACEPUSHER_VERSION}
chmod +x tracepusher
mv tracepusher /usr/local/bin
wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTELCOL_VERSION}/otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz
tar -xf otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz
mv otelcol-contrib otelcol
rm otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.tar.gz

# ---------------------------------------------#
#       🎉 Installation Complete 🎉             #
#           Please proceed now...              #
# ---------------------------------------------#